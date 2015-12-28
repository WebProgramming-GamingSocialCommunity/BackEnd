require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get users_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }                         
    end
    assert_equal ["can't be blank"], json_response['name']
  end

  test "valid signup information" do
    get users_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name:  "Example User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
    assert_equal "Example User", json_response['name']
  end
    
  def json_response
    ActiveSupport::JSON.decode @response.body
  end
  
end