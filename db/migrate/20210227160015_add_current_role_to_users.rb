class AddCurrentRoleToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :current_role, null: true, foreign_key: { to_table: :user_roles }
  end
end
