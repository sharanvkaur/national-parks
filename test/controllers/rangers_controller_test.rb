require 'test_helper'

class RangersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get rangers_new_url
    assert_response :success
  end

end
