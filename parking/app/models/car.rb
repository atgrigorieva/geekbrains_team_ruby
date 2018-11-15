class Car < ApplicationRecord
  has_many :history_of_reservations
  has_many :history_entries
  validates_presence_of :number,
    :region,
    :driver_name,
    :message => "Все поля должны быть заполненны"
  validates :number, :format => { with: /([A-Z0-9]){6}/ },
    :length => {is: 6}
  validates :driver_name, :format => {with: /([А-Яа-яA-Za-z\ ])+/}
  validates :region, :numericality => {only_integer: true}

end
