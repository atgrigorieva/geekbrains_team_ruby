##
# Контроллер для операций с денежными средствами
class PaymentController < ApplicationController
  
  ##
  #тут происходит оплата за место которое
  #в данный момент забронированно за машиной
  def pay_for_reserved
    permitted = set_payment_params
    car = Car.take.where(CarController.set_car_number)
  end
  
  ##
  # для подсчета суммы к оплате
  def calc_amount
    car = Car.take.where(CarController.set_car_number)
    if car.nil?
      render json: {:message => "Car not found"}
      return false 
    end

    reserved = HistoryReservation.find_last_reservation(car)
    if reserved.nil?
      render json: {:message => "Place not reserved for this car"}
      return false
    end

    debt = History_of_cashbox.how_much_money_car_must_be_pay_for(reservation)
    render json: {
      :car_info => {
        :number => (car.number + car.region),
        :driver => car.driver_name,
        :rate => reservation.rate
      },
      :debt => debt
    }
    return true
  end
  
  ##
  # для фиксации текущей суммы в кассе и высчета расхождений
  def open_or_close_day
    
  end

  private


  # Подтверждаем параметры платежа
  def set_payment_params
    params.permit(:paid, :payment_type)
  end

end
