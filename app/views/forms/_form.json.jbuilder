json.extract! form, :id, :first_name, :last_name, :email_address, :address, :city, :state, :zipcode, :gender, :grade, :dietary_restrictions, :dietary_restrictions_description, :emergency_contact_name, :emergency_contact_relationship, :emergency_contact_phone, :emergency_contact_address, :emergency_contact_city, :emergency_contact_state, :emergency_contact_zipcode, :created_at, :updated_at
json.url form_url(form, format: :json)