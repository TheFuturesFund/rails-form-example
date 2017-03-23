class Form < ApplicationRecord
  enum gender: [ :male, :female, :other ]
  enum grade: [ "9th", "10th", "11th", "12th" ]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email_address, presence: true, format: { with: /\A\S+@\S+\z/ }
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates :gender, presence: true
  validates :grade, presence: true
  validates :dietary_restrictions_description, presence: true, if: :dietary_restrictions?
  validates :emergency_contact_name, presence: true
  validates :emergency_contact_relationship, presence: true
  validates :emergency_contact_phone, presence: true
  validates :emergency_contact_address, presence: true
  validates :emergency_contact_city, presence: true
  validates :emergency_contact_state, presence: true
  validates :emergency_contact_zipcode, presence: true
end
