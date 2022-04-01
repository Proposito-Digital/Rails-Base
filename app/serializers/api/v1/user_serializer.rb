# frozen_string_literal: true
class Api::V1::UserSerializer < Api::V1::BaseSerializer
  attributes :id, :name, :deleted_at
end
