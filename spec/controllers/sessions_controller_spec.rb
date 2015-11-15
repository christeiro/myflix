require 'spec_helper'

describe SessionsController do
  describe "GET #new" do
    it "redirects to home page for authenticated user" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST #create" do
    it "authenticates existing user" do
      user = Fabricate(:user)
      post :create, email: Fabricate(:user).email, password: Fabricate(:user).password
      expect(response).to redirect_to home_path
    end
    it "redirects to sign in path for non authenticated user" do
      user = Fabricate(:user)
      post :create, email: Fabricate(:user).email, password: Faker::Lorem.word
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "GET #destroy" do
    it "logs out authenticated user" do
      session[:user_id] = Fabricate(:user)
      get :destroy
      expect(assigns(:session)).to be(nil)
    end
  end
end

