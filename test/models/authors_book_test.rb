# == Schema Information
#
# Table name: authors_books
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#  book_id    :integer
#
# Indexes
#
#  index_authors_books_on_author_id  (author_id)
#  index_authors_books_on_book_id    (book_id)
#
require 'test_helper'

class AuthorsBookTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:author).class_name('Author')
    should belong_to(:book).class_name('Book')
  end

  test 'author uniqueness' do
    book = Book.last
    author = Author.last

    # Ensure the Author is already assigned
    assert book.authors.include?(author)

    # Reassign Author
    authors_book = book.authors_books.new(author: author)
    refute authors_book.valid?
    assert authors_book.errors.full_messages.last == 'Author can only assign the same author once'
  end
end
