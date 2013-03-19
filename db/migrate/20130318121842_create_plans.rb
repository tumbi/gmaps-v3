class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|

      t.string :title
      t.text :description
      t.float :price
      t.string :frequency
      t.timestamps
    end
  end
end
