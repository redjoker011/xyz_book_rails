# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id            :integer          not null, primary key
#  edition       :string
#  image_url     :string
#  isbn_thirteen :string
#  price         :decimal(8, 2)
#  publicated_at :date
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  publisher_id  :integer
#
# Indexes
#
#  index_books_on_publisher_id  (publisher_id)
#
class Book < ApplicationRecord
  validates :title,
            :price,
            :publicated_at,
            :publisher_id,
            :isbn_thirteen,
            presence: true

  validates :isbn_thirteen,
            format: {
              with: /^(?:\d[\ |-]?){13}$/,
              multiline: true,
              message: 'Please ensure ISBN-13 is valid'
            }

  validates :title, uniqueness: true
  validates :authors_books, presence: true

  has_many :authors_books, inverse_of: :book
  has_many :authors, through: :authors_books

  belongs_to :publisher
end
