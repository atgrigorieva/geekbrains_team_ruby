FactoryBot.define do
  factory :free_place, class: ParkingPlace do
    parking
    number  {1}
    busy    {false}
  end
end
