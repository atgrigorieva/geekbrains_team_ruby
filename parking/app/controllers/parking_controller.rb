class ParkingController < ApplicationController

  ##
  # ищем свободное парковочное место
  def free_place
    parking = find_parking
    # после добавление авторизации можно будет оставить вот эту функцию, и удалить find_parking
    # current_user.operator.parking.parking_places.all.where(:busy => false).sample
    place = ParkingPlace.select(:number).where(:parking => parking, :busy => false).sample
    unless place.nil?
      render json: {:free_place => place.number} 
      return true
    end
    render json: {:free_place => -1, message: "Нет свободных мест"}
    return false
  end

  private
  ##
  # ищем парковку по текущему оператору
  def find_parking
    # вот эта херня поидее должна работать, когда 
    # у нас появится гем devise
    # operator = current_user.operator.parking
    Parking.order(number_of_places: :desc).first
  end
    
end
