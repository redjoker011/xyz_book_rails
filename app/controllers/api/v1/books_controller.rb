# frozen_string_literal: true

# API Module
module Api
  # V1 API Module
  module V1
    # Book API Controller
    class BooksController < ActionController::API
      before_action :valid_isbn_format?
      before_action :initialize_isbn, only: :convert_isbn

      # Fetch book by isbn
      #
      # @return [JSON]
      def book
        isbn = params[:id]

        @book = Book.find_by_isbn_thirteen(isbn)

        if @book
          response_success
        else
          response_not_found
        end
      end

      def convert_isbn
        isbn_ten = @isbn_service.to_ten(params[:id])
        render json: {
          isbn_ten: format_isbn_ten(isbn_ten),
          isbn_thirteen: params[:id]
        }
      rescue InvalidISBNError, Invalid13DigitISBN
        response_invalid_format
      end

      private

      # 200 HTTP Code Response
      def response_success
        render json: {
          id: @book.id,
          title: @book.title,
          price: @book.price,
          publisher: @book.publisher.name,
          authors: @book.author_names
        }
      end

      # 404 HTTP Code Response
      def response_not_found
        render json: { error: 'not-found'.to_json }, status: 404
      end

      # 400 HTTP Code Response
      def response_invalid_format
        render json: { error: 'id param is not a valid ISBN-13 Digit'.to_json }, status: 400
      end

      # Validate ISBN Format
      #
      # @return [JSON]
      def valid_isbn_format?
        is_valid = params[:id].match(Book::ISBN_THIRTEEN_FORMAT).present?

        return response_invalid_format unless is_valid
      end

      # Initialize ISBN class
      def initialize_isbn
        @isbn_service = ISBN.new
      end

      # @param [String] isbn
      #
      # @return [String] formatted isbn
      def format_isbn_ten(isbn)
        isbn.gsub(/(\d{1})(\d{3})(\d{5})(\d{1})/, '\\1-\\2-\\3-\\4')
      end
    end
  end
end
