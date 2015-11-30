require 'spec_helper'

feature "Signing in" do
  scenario "Signing in with correct credentials" do
    alice = Fabricate(:user)
    sign_in(alice)
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