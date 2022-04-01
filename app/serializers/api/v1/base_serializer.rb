# frozen_string_literal: true
class Api::V1::BaseSerializer < ActiveModel::Serializer

  attributes :created_at,:updated_at
  def created_at
    object.created_at.in_time_zone.iso8601 if object.created_at
  end

  def updated_at
    object.updated_at.in_time_zone.iso8601 if object.created_at
  end
end