class CreateForms < ActiveRecord::Migration[5.0]
  def change
    create_table :forms do |t|
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.integer :gender
      t.integer :grade
      t.boolean :dietary_restrictions
      t.string :dietary_restrictions_description
      t.string :emergency_contact_name
      t.string :emergency_contact_relationship
      t.string :emergency_contact_phone
      t.string :emergency_contact_address
      t.string :emergency_contact_city
      t.string :emergency_contact_state
      t.string :emergency_contact_zipcode

      t.timestamps
    end
  end
end
