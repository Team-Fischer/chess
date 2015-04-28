require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test 'should be able to get homepage' do
    get :index
    assert_response :success
  end

end
