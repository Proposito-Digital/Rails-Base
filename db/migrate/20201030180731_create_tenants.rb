class CreateTenants < ActiveRecord::Migration[6.0]
  def change
    create_table :tenants do |t|
      t.string :name
      t.string :slug
      t.timestamp :deleted_at

      t.timestamps
    end
    add_index :tenants, :deleted_at
  end
end
