require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:michael)
  end

  test "should get index" do
    get :index
    json = JSON.parse(response.body)
    assert_response :success
    users_names = json.map { |m| m["name"] }
    assert_equal users_names, ["Michael Example", "Alice"]   
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { name:'bed', email:'kkk@msn.com', password:'123456', password_confirmation:'123456' }, format: :json
    end

    assert_response :success
  end

  test "should show user" do
    get :show, id: @user, format: :json
    assert_response :success
    assert_equal @user.email, json_response['user']['email']
  end
  
  test "should show user's post" do
    get :show, id: @user, format: :json
    assert_response :success
    assert_equal @user.posts[1]['content'], json_response['posts'][1]['content']
  end

  test "should update user" do
    patch :update, id: @user, user: { name:'bek', email:'1e43@fjl.com', password:'12345678', password_confirmation:'12345678' }, format: :json
    assert_response :success
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user, format: :json
    end

    assert_response 204
  end
    
  def json_response
    ActiveSupport::JSON.decode @response.body
  end  
  
end
