# frozen_string_literal: true

# API Module
module Api
  # V1 API Module
  module V1
    # Book API Controller
    class BooksController < ActionController::API
      include Bookable

      before_action :initialize_isbn
      before_action :valid_isbn_format?
      before_action :validate_isbn_thirteen

      # Fetch book by isbn
      # /api/v1/books/{:id}
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

      # Convert ISBN 13 to ISBN 10
      # /api/v1/books/{:id}/convert-isbn
      #
      # @return [JSON]
      def convert_isbn
        isbn_ten = @isbn_service.to_ten(params[:id])

        render json: {
          isbn_ten: format_isbn_ten(isbn_ten),
          isbn_thirteen: params[:id]
        }
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

      # @param [String] isbn
      #
      # @return [String] formatted isbn
      def format_isbn_ten(isbn)
        isbn.gsub(/(\d{1})(\d{3})(\d{5})(\d{1})/, '\\1-\\2-\\3-\\4')
      end
    end
  end
end
