require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end
  
  test "get new category form and create category" do
    sign_in_as(@user, "password")
    get new_category_path                                                       # go to new_category_path
    assert_template 'categories/new'                                            # get the new category form
    assert_difference 'Category.count', 1 do                                    
      post_via_redirect categories_path, category: {name: "sports"}             # http post request to new form, creating a category called sport
    end
    assert_template 'categories/index'                                          # then redirect to categories index page
    assert_match "sports", response.body                                        # and check to see if "sports" is displayed on the page
  end
  
  test "invalid category submission results in failure" do
    sign_in_as(@user, "password")
    get new_category_path                                                       # go to new_category_path
    assert_template 'categories/new'                                            # get the new category form
    assert_no_difference 'Category.count' do                                    
      post categories_path, category: {name: " "}                  # http post request to new form, creating a category called sport
    end
    assert_template 'categories/new'                                            # then redirect to categories new page
    assert_select 'h2.panel-title'                                              # look for the h2 panel-title div from views/shared/_errors.html.erb
    assert_select 'div.panel-body'
  end
end