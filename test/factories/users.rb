FactoryGirl.define do
  factory :user do
    provider "facebook"
    sequence(:uid) { |n| "#{n}" }
    sequence(:name) { |n| "Person_#{n}" }
  end
end
