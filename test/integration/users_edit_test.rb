require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
  
  test "unsuccessful edit" do
    log_in_as(users(:one))
    patch user_path(@user), user: { name:  "",
                                    email: "foo@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_response(422)
  end  
  
  test "successful edit" do
    log_in_as(users(:one))  
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { name:  name,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }

    assert_response(200)
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end