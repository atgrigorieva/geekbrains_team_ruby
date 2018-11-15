FactoryBot.define do
  factory :operator do
    name { "test" }
    association :user, factory: :operator_user, strategy: :build
    association :parking, factory: :parking, strategy: :build 
  end
end
