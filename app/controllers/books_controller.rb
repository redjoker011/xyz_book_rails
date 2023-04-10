class BooksController < ApplicationController
  def index; end

  def show
    isbn = params[:id]
    @book = Book.find_by_isbn_thirteen(isbn)

    respond_to do |format|
      format.html
      format.json { render json: @book }
    end
  end
end
