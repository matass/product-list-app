# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products
      resources :tags
    end
  end

  namespace :web do
    resources :products, only: [:index, :show] do
      resources :tags, only: [:index, :show]
    end
  end
end
