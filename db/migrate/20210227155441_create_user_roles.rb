class CreateUserRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_roles do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :role
      t.timestamp :deleted_at

      t.timestamps
    end
    add_index :user_roles, :deleted_at
  end
end
