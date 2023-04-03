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
require 'test_helper'

class BookTest < ActiveSupport::TestCase
  context 'associations' do
    should have_many(:authors_books).class_name('AuthorsBook')
    should have_many(:authors).through(:authors_books)
    should belong_to(:publisher).class_name('Publisher')
  end

  context 'validations' do
    should validate_presence_of(:title)
    should validate_presence_of(:price)
    should validate_presence_of(:isbn_thirteen)
    should validate_presence_of(:publicated_at)
    should validate_presence_of(:authors_books)
    should validate_uniqueness_of(:title)
  end
end
