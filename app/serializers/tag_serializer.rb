# frozen_string_literal: true

class TagSerializer < ActiveModel::Serializer
  type :tag

  attributes :id, :title, :discarded_at
end
