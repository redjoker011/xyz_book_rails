require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  test 'should render index page' do
    get '/'
    assert_response :success
  end
end
