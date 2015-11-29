require 'spec_helper'

feature "Signing in" do
  scenario "Signing in with correct credentials" do
    alice = Fabricate(:user)
    visit(sign_in_path)
    fill_in "email", with: alice.email
    fill_in "password", with: alice.password
    click_button('Sign in')
    expect(page).to have_content alice.full_name
  end

  scenario "Signing in with incorrect credentials" do
    visit(sign_in_path)
    fill_in "email", with: Faker::Internet::email
    fill_in "password", with: Faker::Internet::password
    click_button('Sign in')
    expect(page).to have_content 'Your username or password are incorrect! Please try again!'
  end
end