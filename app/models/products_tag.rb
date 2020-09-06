# frozen_string_literal: true

class ProductsTag < ApplicationRecord
  belongs_to :product
  belongs_to :tag
end
