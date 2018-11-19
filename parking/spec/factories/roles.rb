FactoryBot.define do
  factory :operator_role, class: Role do
    id    {1}
    name  {"operator"}
    factory :owner_role do
      id    {2}
      name  {"owner"}
    end
  end
end
