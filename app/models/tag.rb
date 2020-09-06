# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :products_tags
  has_many :products, through: :products_tags

  validates :title, uniqueness: true, presence: true

  default_scope { where(discarded_at: nil) }
end
