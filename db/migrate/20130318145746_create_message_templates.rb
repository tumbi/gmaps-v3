class CreateMessageTemplates < ActiveRecord::Migration
  def change
    create_table :message_templates do |t|

      t.string :subject
      t.text :body
      t.integer :company_id
      t.text :signature
      t.timestamps
    end
  end
end
