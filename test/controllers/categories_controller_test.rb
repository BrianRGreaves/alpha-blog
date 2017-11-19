require "test_helper"

class CategoriesControllerTest < ActionController::TestCase
  
  def setup
    @category = Category.create(name: "sports") # create because we want it to hit the test DB
  end
  
  #Test routes are accesible
  test "should get categories index" do
    get :index # get is the http request
    assert_response :success
  
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should get show" do
    get(:show, {'id' => @category.id})
    assert_response :success
  end
  
end