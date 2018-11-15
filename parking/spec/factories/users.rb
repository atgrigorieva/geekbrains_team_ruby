FactoryBot.define do
  factory :owner_user, class: User do
    id {1}
    email { FFaker::Internet.email }
    association :role, factory: :owner_role, strategy: :build
    login { FFaker::Internet.user_name}
    password { "notoperator" }
    password_confirmation { "notoperator" }
  end
  factory :operator_user, class: User  do
    id {2}
    association :role, factory: :operator_role, strategy: :build
    login { FFaker::Internet.user_name}
    password { "operator" }
    password_confirmation { "operator" }
  end
end
