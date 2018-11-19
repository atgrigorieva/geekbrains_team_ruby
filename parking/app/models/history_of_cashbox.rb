class HistoryOfCashbox < ApplicationRecord
  belongs_to :history_reservation
  belongs_to :user
  belongs_to :cash_box_operation
  belongs_to :pay_type
  belongs_to :parking



  scope :has_pay_for_this?, ->(reservation) {find_by(:history_reservation => reservation)}
  
  def how_much_money_car_must_be_pay_for(reservation)
    diff = Time.now - reservation.day_in.month
    case reservation.rate.name
    when 'month'
      diff = diff/60/60/24/30
    when 'day'
      diff = diff/60/60/24
    when 'hour'
      diff = diff/60/60
    end
    return diff.to_i*reservation.rate.price
  end
end
