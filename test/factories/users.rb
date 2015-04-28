FactoryGirl.define do
  factory :user do
  	id 1
  	email {SecureRandom.urlsafe_base64(5) + '@gmail.com'}
  	password '12356789'
  end

end
