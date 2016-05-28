FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| Faker::Internet.email.gsub("@", "-#{n}@") }
    first_name       { Faker::Name.first_name }
    last_name        { Faker::Name.last_name }
    password         { Faker::Internet.password }
  end
end
