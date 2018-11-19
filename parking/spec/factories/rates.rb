FactoryBot.define do
  factory :month_rate, class: Rate do
    id {1}
    parking
    association :rate_interval, factory: :month_inteval, strategy: :build
    name        {"Помесячная"}
    price       {rand(1000.00..3000.00).round(2)}
    date_from   {Time.now}
    date_to     {Time.new(9999,1,1,1,1)}
    factory :day_rate do
        id {2}
        association :rate_interval, factory: :day_inteval, strategy: :build
        name        {"Ежедневная"}
        price       {(rand(200.00..500.00).round(2))}
    end
    factory :hour_rate do
        id {3}
        association   :rate_interval, factory: :hour_inteval, strategy: :build
        name          {"Час"}
        price         {(rand(50.00..200.00).round(2))}
    end
  end
end
