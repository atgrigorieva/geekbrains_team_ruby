FactoryBot.define do
  factory :history_reservation do
    association :rate, factory: :month_rate, strategy: :build
    association :car, factory: :car_reserv, strategy: :build
    association :parking_place, factory: :free_place, strategy: :build
    date_in { Time.new(2018, 05, 01) }
  end
end
