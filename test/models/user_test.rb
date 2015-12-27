require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "Ben", email: "user@example.com",
                    password: "123456", password_confirmation: "123456")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end
  
  test "associated posts should be destroyed" do
    @user.save
    @user.posts.create!(content: "Lorem ipsum")
    assert_difference "Post.count", -1 do
      @user.destroy
    end
  end  
  
end
