# frozen_string_literal: true
class CreateApiKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :api_keys do |t|
      t.string :access_token
      t.timestamps
      t.datetime :deleted_at
    end
    add_index :api_keys, :deleted_at
  end
end
