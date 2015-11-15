require 'spec_helper'

describe UsersController do
  describe "GET #new" do
    it "initializes the @user" do
      get :new
      expect(assigns(:user)).to be_new_record
    end
  end
end