# frozen_string_literal: true

class ProductTagSerializer < ActiveModel::Serializer
  attributes :products, :tags
end
