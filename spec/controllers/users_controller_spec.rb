require 'spec_helper'

describe UsersController do
  describe "GET #new" do
    it "initializes the @user for unauthenticated user" do
      get :new
      expect(assigns(:user)).to be_new_record
    end
    it "redirects to home page for authenticated user" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST #create" do
    it "creates a new user" do
      post :create, user: {email: Faker::Internet.email, full_name: Faker::Name.name, password: 'password'}
      expect(response).to redirect_to sign_in_path
    end
    it "does not create a new user if the user exist" do
      post :create, user: {email: Fabricate(:user).email, full_name: Faker::Name.name, password: 'password'}
      expect(response).to render_template :new
    end
  end
end