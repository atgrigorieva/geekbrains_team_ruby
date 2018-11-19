class HistoryReservation < ApplicationRecord
  belongs_to :rate
  belongs_to :parking_place
  belongs_to :car
  scope :find_last_reservation, ->(car) {find_by(:car => car, :date_out => '')}
end
