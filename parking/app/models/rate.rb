class Rate < ApplicationRecord
  has_many :history_reservations
  belongs_to :parking
  belongs_to :rate_interval
end
