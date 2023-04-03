# frozen_string_literal: true

# API Module
module Api
  # V1 API Module
  module V1
    # Book API Controller
    class BooksController < ActionController::API
      # Fetch book by isbn
      #
      # @return [JSON]
      def book
        isbn = params[:id]

        return response_invalid unless valid_isbn?

        @book = Book.find_by_isbn_thirteen(isbn)

        if @book
          response_success
        else
          response_not_found
        end
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
      def response_invalid
        render json: { error: 'id param invalid'.to_json }, status: 400
      end

      # Validate ISBN Format
      #
      # @return [Boolean]
      def valid_isbn?
        params[:id].match(Book::ISBN_THIRTEEN_FORMAT).present?
      end
    end
  end
end
