# frozen_string_literal: true

class API::V1::TagsController < API::APIController
  before_action :set_tag_item, only: [:update]

  def index
    tags = Tag.all

    render json: tags
  end

  def create
    Tag.transaction do
      tag = Tag.new(permited_params)

      unless tag.save
        render_json_validation_error tag
        return
      end

      render json: tag
    end
  end

  def update
    Tag.transaction do
      @tag.update(permited_params)

      render json: @tag
    end
  end

  private

  def permited_params
    params
      .require(:data)
      .require(:attributes)
      .permit(:id, :title)
  end

  def set_tag_item
    @tag = Tag.find(params[:data][:id])
  end
end
