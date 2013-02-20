class AddEmailToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :email, :string
  end
end
