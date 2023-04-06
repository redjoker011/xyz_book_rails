require 'test_helper'

class ISBNTest < ActiveSupport::TestCase
  setup do
    @service = ISBN.new
  end

  def test_isbn_ten_to_isbn_ten
    expected_isbn = '1-891-83085-6'
    generated_isbn = @service.to_ten(expected_isbn)

    assert_equal(expected_isbn.delete('-'), generated_isbn)
  end

  def test_isbn_thirteen_to_isbn_ten
    isbn = '978-1891830-85-3'
    expected_isbn = '1-891-83085-6'
    generated_isbn = @service.to_ten(isbn)

    assert_equal(expected_isbn.delete('-'), generated_isbn)
  end

  def test_isbn_ten_to_isbn_thirteen
    isbn = '1-891-83085-6'
    expected_isbn = '978-1891830-85-3'
    generated_isbn = @service.to_thirteen(isbn)

    assert_equal(expected_isbn.delete('-'), generated_isbn)
  end

  def test_isbn_thirteen_to_isbn_ten_ending_in_x
    isbn = '978-1-60309-038-4'
    expected_isbn = '1-603-09038-X'
    generated_isbn = @service.to_ten(isbn)

    assert_equal(expected_isbn.delete('-'), generated_isbn)
  end

  def test_isbn_ten_to_isbn_thirteen_ending_in_x
    isbn = '1-603-09038-X'
    expected_isbn = '978-1-60309-038-4'
    generated_isbn = @service.to_thirteen(isbn)

    assert_equal(expected_isbn.delete('-'), generated_isbn)
  end
end
