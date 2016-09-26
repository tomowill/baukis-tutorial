FactoryGirl.define do
  factory :administrators do
    sequence(:email) { |n| "member#{n}@example.com" }
    password 'pw'
    suspended false 
  end
end
