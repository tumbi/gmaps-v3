class AssetsCharacters < ActiveRecord::Migration
  def self.up
    create_table :assets_characters do |t|
      t.integer :asset_id
      t.integer :character_id
    end
  end

  def self.down
    drop_table :assets_characters
  end
end
