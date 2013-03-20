class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :company_id
      t.string :name
      t.text :description
      t.string :model
      t.integer :quantity

      t.timestamps
    end
  end
end
