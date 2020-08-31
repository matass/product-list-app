# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  type :product

  attributes :name, :description, :price, :tags

  has_many :tags # relationships
end
