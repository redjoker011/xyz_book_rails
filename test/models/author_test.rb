# == Schema Information
#
# Table name: authors
#
#  id          :integer          not null, primary key
#  first_name  :string
#  last_name   :string
#  middle_name :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  context 'associations' do
    should have_many(:authors_books).class_name('AuthorsBook')
    should have_many(:books).through(:authors_books)
  end

  context 'validations' do
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
  end
end
