class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|

      t.string :company_name
      t.string :subdomain
      t.string :address
      t.string :phone_number
      t.string :fax_number
      t.string :company_type
      t.timestamps
    end
  end
end
