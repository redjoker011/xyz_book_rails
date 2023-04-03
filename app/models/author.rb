# frozen_string_literal: true

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
class Author < ApplicationRecord
  validates :first_name, :last_name, presence: true, uniqueness: true

  has_many :authors_books
  has_many :books, through: :authors_books
end
