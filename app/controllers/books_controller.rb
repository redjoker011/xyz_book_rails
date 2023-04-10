class BooksController < ApplicationController
  include Bookable

  before_action :initialize_isbn, only: :show
  before_action :validate_isbn_thirteen, only: :show

  def index; end

  def show
    @book = Book.find_by_isbn_thirteen(@isbn)

    render json: { html: render_to_string(partial: 'books/book') }
  end
end
