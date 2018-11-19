class Parking < ApplicationRecord
  belongs_to :owner
  has_many :operators
  has_many :rates
  has_many :parking_places
end
