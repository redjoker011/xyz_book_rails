# frozen_string_literal: true

# == Schema Information
#
# Table name: publishers
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Publisher < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :books
end
