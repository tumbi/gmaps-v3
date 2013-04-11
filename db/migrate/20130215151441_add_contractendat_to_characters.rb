class AddContractendatToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :contractendon, :date
  end
end
