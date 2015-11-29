require 'spec_helper'

feature "Signing in" do
  background do
    User.create!(full_name: "Testing Account", email: "test@test.info", password: "test")
  end

  scenario "Signing in with correct credentials" do
    visit(sign_in_path)
    fill_in('email', :with => 'test@test.info')
    fill_in('password', :with => 'test')
    click_button('Sign in')
    expect(page).to have_content 'You are signed in, enjoy!'
  end

  scenario "Signing in with incorrect credentials" do
    visit(sign_in_path)
    fill_in('email', :with => 'test@test.info')
    fill_in('password', :with => 'test')
    click_button('Sign in')
    expect(page).to have_content 'Your username or password are incorrect! Please try again!'
  end
end