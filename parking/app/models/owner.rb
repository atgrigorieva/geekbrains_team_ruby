class Owner < ApplicationRecord
  belongs_to :user
  has_many :parkings
end
