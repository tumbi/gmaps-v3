class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :timezone, :string
    add_column :users, :mobile_number, :string
    add_column :users, :country, :string
    add_column :users, :is_active, :boolean, :default => false
    add_column :users, :company_id, :integer
  end
end
