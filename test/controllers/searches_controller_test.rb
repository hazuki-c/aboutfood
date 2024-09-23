require "test_helper"

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get form" do
    get searches_form_url
    assert_response :success
  end
end
