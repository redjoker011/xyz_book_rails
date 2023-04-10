class BooksController < ApplicationController
  def index; end

  def show
    isbn = params[:id]
    @book = Book.find_by_isbn_thirteen(isbn)

    render json: { html: render_to_string(partial: 'books/book') }
  end
end
