# frozen_string_literal: true

class BooksControllerTest < ActionDispatch::IntegrationTest
  test 'get book should successfully' do
    get '/api/v1/books/978-1-891830-85-3'
    assert_response :success
  end

  test 'get book should respond not found' do
    get '/api/v1/books/978-1-891830-85-5'
    assert_response :not_found
  end

  test 'get book should raise 400' do
    get '/api/v1/books/979-1-891830-85-5'
    assert_response(400)
  end

  test 'convert isbn-13 to isbn-10 should successfully' do
    get '/api/v1/books/978-1-891830-85-3/convert-isbn'
    assert_response :success
  end

  test 'convert isbn-13 to isbn-10 should raise 400' do
    get '/api/v1/books/979-1-891830-85-5/convert-isbn'
    assert_response(400)
  end
end
