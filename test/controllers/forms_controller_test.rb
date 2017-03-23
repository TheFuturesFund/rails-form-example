require 'test_helper'

class FormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @form = forms(:one)
  end

  test "should get index" do
    get forms_url
    assert_response :success
  end

  test "should get new" do
    get new_form_url
    assert_response :success
  end

  test "should create form" do
    assert_difference('Form.count') do
      post forms_url, params: { form: { address: @form.address, city: @form.city, dietary_restrictions: @form.dietary_restrictions, dietary_restrictions_description: @form.dietary_restrictions_description, email_address: @form.email_address, emergency_contact_address: @form.emergency_contact_address, emergency_contact_city: @form.emergency_contact_city, emergency_contact_name: @form.emergency_contact_name, emergency_contact_phone: @form.emergency_contact_phone, emergency_contact_relationship: @form.emergency_contact_relationship, emergency_contact_state: @form.emergency_contact_state, emergency_contact_zipcode: @form.emergency_contact_zipcode, first_name: @form.first_name, gender: @form.gender, grade: @form.grade, last_name: @form.last_name, state: @form.state, zipcode: @form.zipcode } }
    end

    assert_redirected_to form_url(Form.last)
  end

  test "should show form" do
    get form_url(@form)
    assert_response :success
  end

  test "should get edit" do
    get edit_form_url(@form)
    assert_response :success
  end

  test "should update form" do
    patch form_url(@form), params: { form: { address: @form.address, city: @form.city, dietary_restrictions: @form.dietary_restrictions, dietary_restrictions_description: @form.dietary_restrictions_description, email_address: @form.email_address, emergency_contact_address: @form.emergency_contact_address, emergency_contact_city: @form.emergency_contact_city, emergency_contact_name: @form.emergency_contact_name, emergency_contact_phone: @form.emergency_contact_phone, emergency_contact_relationship: @form.emergency_contact_relationship, emergency_contact_state: @form.emergency_contact_state, emergency_contact_zipcode: @form.emergency_contact_zipcode, first_name: @form.first_name, gender: @form.gender, grade: @form.grade, last_name: @form.last_name, state: @form.state, zipcode: @form.zipcode } }
    assert_redirected_to form_url(@form)
  end

  test "should destroy form" do
    assert_difference('Form.count', -1) do
      delete form_url(@form)
    end

    assert_redirected_to forms_url
  end
end
