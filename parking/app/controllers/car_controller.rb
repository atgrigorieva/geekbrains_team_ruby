class CarController < ApplicationController
  # before_action :set_current_user
  before_action :set_current_parking
  ## 
  # Машина приехала на парковку
  def entry_or_leave
    # определяем приехала машина или уехала
    puts "-"*30
    puts params
    action = params.permit(:enter)
    # ищем машину в бд
    puts ""
    car = set_car_number
    unless car
      render json: @error
      return false  
    end

    car = Car.find_by(:number => car[:number],:region => car[:region])

    # Когда машина не найдена
    if car.nil?
      if action
        render json: {
          :found => false,
          :message => "car not found",
          :rates => @current_parking.rates.map { |rate| [rate.name, rate.price, rate.rate_interval.name]}
        }
        return false
      else
        render json: {
          :found => false,
          :message => "car not found"
        }
        return false
      end
    end

    # Поиск брони
    reserved = HistoryReservation.find_last_reservation(car)

    # Когда бронь есть
    unless reserved.nil?
      unless check_move_car(car, action)
        render json: {error: true, message: "troble with check entry"}
        return false
      end
      if action
        render json: {
          :found => true,
          :reserved => true} 
        return true
      else # Когда машина выезжает с парковки
        score = HistoryOfCashbox.has_pay_for_this?(reserved)
        if score.nil? # Проверяем заплатила ли она 
          # Считаем сколько необходимо заплатить
          debt = HistoryOfCashbox.how_much_car_must_be_pay_for(reserved)
          render json: {
            :found => true,
            :payed => false,
            :car_info => {
              :number =>(car.number + car.region),
              :driver => (car.driver_name),
            },
            :debt => debt
          }
          return true
        else # Все хорошо если заплатила
          render json: {found: true, :payed => true} 
          return true
        end
      end
    else 
      # Когда брони нету
      if action
        render json: {
          :found => true, 
          :reserved => false,
          :car_info => {
            :number => (car.number + car.region),
            :driver => car.driver_name
          },
          :rates => @current_parking.rates.map { |rate| [rate.name, rate.price, rate.rate_interval.name]}
        
        }
        return true
      end
    end
    render json: {error: true,message: "fail, uncorrected data"}
    return false
  end

  ##  
  # создание машины в бд 
  def create
    car = set_car_params
    unless car
      render json: @error
      return false  
    end
    car = Car.create!(car)
    # создание брони
    if !car.nil? && new_reservation(car)
      # создание записи о въезде
      check_move_car(car=car, entry=true)
      # возврат
      render json: {:error => false, :message => "car created"} 
      return true
    end
    render json: {:error => true, :message => "some trouble"}
    return false
  end

  ## 
  # Создает бронь для существующей в базе машины
  def old_car_new_reservation
    car = Car.find_by(set_car_params)
    unless car.nil? and new_reservation  
        render json: {:message => 'success'}
        return true
    end
    render json: {:message => "car not found"}
    return false
  end
  
  private
  
  ##
  # Включает параметр номера автомобиля
  def set_car_number
    parse_number params.require(:car_number).permit(:number)
  end
  
  ##
  # Включает параметры новой машины
  def set_car_params
    tmp = parse_number params.require(:car_setting).permit(:number,:driver_name)
    tmp == false ? false : tmp
  end
    
  ##
  # Включает параметры брони
  def set_reservation_params
    tmp_par = params.require(:reservation).permit(:rate,:parking_place)  
    # ---------------------------------Нужно заменить отбор по парковке на парковку оператора
    rate = @current_parking.rates.find_by(name: tmp_par[:rate]) 
    return false if rate.nil?
    tmp_par.merge!(:rate => rate )
    parking_place = @current_parking.parking_places.find_by(:number => tmp_par[:parking_place])
    tmp_par.merge!(:parking_place => parking_place)
    tmp_par
  end
  ##  
  # Разделяет номер от региона
  def parse_number(parm)
    template = /((?:[A-Z]){3}(?:[0-9]){3})|((?:[A-Z]){1}(?:[0-9]){3}(?:[A-Z]){2})|((?:[0-9]){3}(?:[A-Z]){3})/
    region = parm[:number].gsub(/([A-Z0-9]){6}/,'')
    number = parm[:number].gsub(/(([A-Z0-9]){6})(([0-9])+)/,'\1')
    if (number.scan template).empty?
      @error = {error: true, message: "Номер должен быть в одном из форматов:\nYYY999 Y999YY 999YYY после номер только цифры обозначающие регион"}
      return false
    end
    parm.merge!({:region => region,:number => number})
    return parm
  end
  
  ## 
  # Создает новую бронь
  def new_reservation(car=nil)
    if car.nil?
      return false
    end
    res_param = set_reservation_params
    return false unless res_param
    new_param = res_param.merge({:car => car, :date_in => Time.now})
    reserv = HistoryReservation.create!(new_param)
    return false if reserv.nil?
    reserv.parking_place.update(:busy => true)
    return true
  end

  ##
  # учет въезда выезда авто
  def check_move_car(car=nil, entry=false)
    car.nil? ? (return false) : true
    if entry
      save = HistoryEntry.create!(:car => car,:date => Time.now, action: entry)
    else
      save = HistoryEntry.create!(:car => car,:date => Time.now, action: entry)
    end
    return false if save.nil?
    return true
  end




  def set_current_parking
    if user_signed_in?
      case current_user.role.name
      when "operator"
        @current_parking = Operator.find_by(:user => current_user)
        if @current_parking.nil?
          return false 
        else 
          @current_parking = @current_parking.parking
          return true
        end
      end
    end
  end
end