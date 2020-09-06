# frozen_string_literal: true

class API::V1::ProductsController < API::APIController
  before_action :set_product_item, only: [:update, :destroy]

  def index
    products = Product.includes(:tags).all # includes to avoid N+1

    render json: products
  end

  def create
    Product.transaction do
      product = Product.new(permited_params)

      unless product.save
        render_json_validation_error product
        return
      end

      render json: product
    end
  end

  def update
    Product.transaction do
      unless @product.update(permited_params)
        render_json_validation_error @product
        return
      end

      render json: @product
    end
  end

  def destroy
    Product.transaction do
      unless @product.touch(:discarded_at)
        render_json_validation_error @product
        return
      end

      render json: @product
    end
  end

  private

  def permited_params
    params
      .require(:data)
      .require(:attributes)
      .permit(:id, :name, :description, :price, tags: [])
  end

  def set_product_item
    @product = Product.find(params[:data][:id])
  end
end
