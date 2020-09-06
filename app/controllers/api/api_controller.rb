# frozen_string_literal: true

class API::APIController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create update destroy]

  def render_json_validation_error(resource)
    render json: resource,
           status: :bad_request,
           adapter: :json_api,
           serializer: ActiveModel::Serializer::ErrorSerializer
  end
end
