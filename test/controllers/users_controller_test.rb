require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should get index" do
    get :index
    json = JSON.parse(response.body)
    assert_response :success
    users_names = json.map { |m| m["name"] }
    assert_equal users_names, ["Michael Example", "Sterling Archer", "Alice"]   
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
 
  test "should return 401 when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }, format: :json
    assert_response 401
  end

  test "should update user" do 
    log_in_as_for_ctrl(@user)
    patch :update, id: @user, user: { name:'bek', email:'1e43@fjl.com', password:'12345678', password_confirmation:'12345678' }, format: :json
    assert_response 200
  end
  
  test "should not update user" do
    log_in_as_for_ctrl(@user)
    patch :update, id: @user, user: { name:'bek', email:'1e43@fjl.com', password:'12345678', password_confirmation:'12678' }, format: :json
    assert_response 422
    assert_equal ["doesn't match Password"], json_response['password_confirmation']
  end

  test "should return 401 when logged in as wrong user" do
    log_in_as_for_ctrl(@other_user)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }, format: :json
    assert_response 401
  end
  
  
  test "should not destroy user" do
    assert_no_difference('User.count') do
      delete :destroy, id: @user, format: :json
  end

    assert_response 401
  end
    
  def json_response
    ActiveSupport::JSON.decode @response.body
  end  
  
end
