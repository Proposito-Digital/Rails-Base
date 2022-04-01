# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # softdelete
  include Discard::Model
  self.discard_column = :deleted_at
  default_scope -> { kept }

  scope :strainer, ->(fields, term) do
    if fields.present? && term.present?
      where(fields.map { |field| field + ' ilike :term' }
            .join(' OR '), term: "%#{term}%")
    end
  end

  scope :sort_for, ->(column, direction) do
    if column.present? && direction.present?
      if column.include? '.'
        belong_to = column.partition('.').first
        field = column.partition('.').last
        reorder("#{belong_to}.#{field} #{direction}")
      else
        reorder("#{column} #{direction}")
      end
    end
  end

  def persisted?
    self.id.present?
  end
end
