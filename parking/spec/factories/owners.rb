FactoryBot.define do
  factory :owner do
    id           {1}
    association  :user, factory: :owner_user, strategy: :build
    first_name   {FFaker::NameRU.first_name}
    last_name    {FFaker::NameRU.last_name}
    second_name  {FFaker::NameRU.patronymic}
  end
end
