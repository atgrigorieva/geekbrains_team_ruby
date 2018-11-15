FactoryBot.define do
  factory :parking do
    id               {1}
    number_of_places {2}
    name             { FFaker::AddressRU.street_address }
    owner
  end
end
