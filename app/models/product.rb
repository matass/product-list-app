# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :products_tags
  has_many :tags, through: :products_tags

  validates :name, uniqueness: true
  validates :price, presence: true

  default_scope { where(discarded_at: nil) }

  def tags=(tags)
    ProductsTag.where(product: self).destroy_all

    tags.each do |title|
      ProductsTag.find_or_create_by(
        {
          product: self,
          tag: Tag.find_or_create_by({ title: title })
        }
      )
    end
  end
end
