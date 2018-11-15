FactoryBot.define do
  factory :month_inteval, class: RateInterval  do
    id      {1}
    name    {"Месяц"}
    factory :day_inteval do
      id    {2}
      name  {"День"}
    end
    factory :hour_interval do
      id    {3}
      name  {"Час"}
    end
  end
end