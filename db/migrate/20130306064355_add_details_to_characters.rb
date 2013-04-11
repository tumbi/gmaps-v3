class AddDetailsToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :contract_number, :integer
    add_column :characters, :mobile_number, :integer
  end
end
