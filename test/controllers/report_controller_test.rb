require "test_helper"

class ReportControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get report_home_url
    assert_response :success
  end
end
