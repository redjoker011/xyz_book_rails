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
class AuthorsBook < ApplicationRecord
  belongs_to :author
  belongs_to :book

  validates :author,
            uniqueness: {
              scope: :book,
              message: 'can only assign the same author once'
            }
end
