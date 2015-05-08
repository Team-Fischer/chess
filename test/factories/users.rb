FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "guy#{n}@example.com" }
    password "thepassword"
    password_confirmation "thepassword"
  end
  factory :facebook_user do
  	provider "facebook"
  	sequence(:uid) { |n| "#{n}" }
    sequence(:name) { |n| "Person_#{n}" }
  end
end
