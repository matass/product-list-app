# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :products_tags
  has_many :tags, through: :products_tags

  validates :name, uniqueness: true
  validates :price, presence: true

  default_scope { where(discarded_at: nil) }

  accepts_nested_attributes_for :tags

  def tags=(tags)
    tags_to_remove = self.tags.pluck(:title) - tags

    if tags_to_remove.any?
      self.tags.delete(Tag.find_by({ title: tags_to_remove }))
    end

    tags.each do |title|
      next if self.tags.find_by({ title: title })

      self.tags << Tag.find_or_create_by({ title: title })
    end
  end
end
