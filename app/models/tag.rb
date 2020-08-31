# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :product_tags
  has_many :products, through: :product_tags

  validates :title, uniqueness: true, presence: true
end
