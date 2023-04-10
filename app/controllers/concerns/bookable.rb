module Bookable
  extend ActiveSupport::Concern

  # Initialize ISBN class
  def initialize_isbn
    @isbn_service = ISBN.new
  end

  # Validate ISBN-13
  def validate_isbn_thirteen
    @isbn = @isbn_service.to_thirteen(params[:id])
  rescue InvalidISBNError, Invalid13DigitISBN
    response_invalid_format
  end

  # Validate ISBN Format
  #
  # @return [JSON]
  def valid_isbn_format?
    is_valid = params[:id].match(Book::ISBN_THIRTEEN_FORMAT).present?

    return response_invalid_format unless is_valid
  end

  # 404 HTTP Code Response
  def response_not_found
    render json: { error: 'not-found'.to_json }, status: 404
  end

  # 400 HTTP Code Response
  def response_invalid_format
    render json: { error: 'id param is not a valid ISBN-13 Digit'.to_json }, status: 400
  end

  # @param [String] isbn
  #
  # @return [String] formatted isbn-10
  def format_isbn_ten(isbn)
    isbn.gsub(/(\d{1})(\d{3})(\d{5})(\d{1})/, '\\1-\\2-\\3-\\4')
  end
end
