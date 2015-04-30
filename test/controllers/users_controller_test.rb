require 'test_helper'

class UsersControllerTest < ActionController::TestCase
 
   test "log-in with facebook" do
   	user = FactoryGirl.create(:user)
   	sign_in user 
   end

end	