# frozen_string_literal: true

# ISBN Conversion and Validation Class
#
# This class only use 978 as prefix for ISBN-13 Digit
class ISBN
  # Generate ISBN-10 Format
  #
  # @param [String] isbn
  #
  # @return [String] isbn
  def to_ten(isbn)
    validate_isbn_string(isbn)

    isbn = isbn.delete('-')
    validate_isbn_thirteen(isbn) if isbn.size == 13

    # get 9 digit isbn
    case isbn.size
    when 10 then isbn = isbn[0..8]
    when 13 then isbn = isbn[/(?:^978)*(.{9})\w/, 1]
    else raise Invalid10DigitISBN
    end

    generate_isbn(isbn: isbn)
  end

  # Generate ISBN-13 Format
  #
  # @param [String] isbn
  #
  # @return [String] isbn
  def to_thirteen(isbn)
    validate_isbn_string(isbn)

    isbn = isbn.delete('-')

    raise InvalidISBNError if isbn.size < 10 || isbn.size > 13

    validate_isbn_thirteen(isbn) if isbn.size == 13

    # adjust to 13 digit isbn and remove check digit
    isbn = isbn.rjust(13, '978')[/(.+)\w/, 1]
    raise Invalid13DigitISBN unless isbn.size == 12

    generate_isbn(isbn: isbn, new_isbn_format: true)
  end

  private

  # ISBN generator
  def generate_isbn(isbn:, new_isbn_format: false)
    return calculate_check_digit_new(isbn) if new_isbn_format

    calculate_check_digit_old(isbn)
  end

  # Calculate ISBN Check Digit for ISBN-10
  #
  # Formula generated using modular arithmetic
  #   11 - (1 * 10, 2 * 9, 3 * 8 ...)
  # @see: https://en.wikipedia.org/wiki/ISBN#ISBN-10_check_digit_calculation
  #
  # @param [String] isbn 9 digit isbn number
  #
  # @return [String]
  def calculate_check_digit_old(isbn)
    new_isbn = (11 - (isbn.split(//).zip((2..10).to_a.reverse).inject(0) { |s, n| s + n[0].to_i * n[1] } % 11))

    isbn << case new_isbn
            when 10 then 'X'
            else new_isbn.to_s
            end
  end

  # Calculate ISBN Check Digit for ISBN-13
  # Formula generated using modular arithmetic
  #   10 - (1 * 1, 2 * 3, 3 * 1, 4 * 3 ...)
  # @see: https://en.wikipedia.org/wiki/ISBN#ISBN-13_check_digit_calculation
  # @param [String] isbn 12 digit isbn number
  #
  # @return [String]
  def calculate_check_digit_new(isbn)
    new_isbn = 10 - (isbn.split(//).zip([1, 3] * 6).inject(0) { |s, n| s + n[0].to_i * n[1] } % 10)

    isbn << case new_isbn
            when 10 then '0'
            else new_isbn.to_s
            end
  end

  # Ensure isbn param is in string format
  #
  # @return [Void]
  def validate_isbn_string(isbn)
    raise InvalidISBNError unless isbn.is_a?(String)
  end

  # Ensure ISBN-13 param starts with 978
  #
  # @return [Void]
  def validate_isbn_thirteen(isbn)
    raise InvalidISBNError unless isbn =~ /^978/
  end
end

class InvalidISBNError < RuntimeError; end
class Invalid10DigitISBN < RuntimeError; end
class Invalid13DigitISBN < RuntimeError; end
