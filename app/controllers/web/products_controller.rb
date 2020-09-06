# frozen_string_literal: true

class Web::ProductsController < API::V1::ProductsController
  def index
    # Product.all.to_json({include: [:tags]}) has performance issue with
    # N+1 queries
    @products = Product.includes(:tags).map do |p|
      {
        id: p.id,
        name: p.name,
        description: p.description,
        price: p.price,
        tags: p.tags
      }
    end
  end
end
