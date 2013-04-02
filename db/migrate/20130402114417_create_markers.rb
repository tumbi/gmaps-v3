class CreateMarkers < ActiveRecord::Migration
  def change
    create_table :markers do |t|
      t.integer :character_id
      t.string :duration
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size

      t.datetime :photo_updated_at

      t.timestamps
    end
  end
end
