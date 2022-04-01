# frozen_string_literal: true
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string     :name
      t.datetime   :token_expiration_time 
      t.string     :access_token

      t.timestamps
      t.datetime :deleted_at
    end
    add_index :users, :deleted_at
  end
end