require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end  
  
  test "should return all posts" do
    get :index
    json = JSON.parse(response.body)
    assert_response :success
    post_titles = json.map { |m| m["title"] }
    assert_equal post_titles, ["kek", "orange", "kitty", "tau"]
  end
    
  test "should return single post" do
    @post = posts(:orange)
    get :show, id:@post, format: :json
    assert_response :success
    assert_equal @post.title, json_response['title']
  end
  
  test "should create post" do
    @user = users(:michael)
    assert_difference('Post.count') do
      post :create, post: {title: "Lorem ipsum", content: "Lorem ipsum", user_id: @user.id}, format: :json
    end
    assert_response :success
  end
    
  def json_response
    ActiveSupport::JSON.decode @response.body
  end      
end