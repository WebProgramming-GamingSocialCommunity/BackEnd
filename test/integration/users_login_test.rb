require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
  test "login with valid information" do
    post login_path, session: { email: @user.email, password: '123456' }
    assert_redirected_to @user
    follow_redirect!
    assert_equal "Michael Example", json_response['user']['name']
  end
    
  def json_response
    ActiveSupport::JSON.decode @response.body
  end
  
end