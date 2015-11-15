require 'spec_helper'

describe VideosController do
  describe "GET #show" do
    let(:futurama) { Fabricate(:futurama) }
    it "sets the @video variable" do
      get :show, id: :futurama.id
      expect(assigns(:video)).to eq([])
    end
    it "renders the show template" do
      spiderman = Video.create(title: "Spiderman", description: "The Spiderman movie")
      get :show, id: spiderman.id
      response.should render_template :show
    end
  end

  describe "POST #search" do
    it "sets the @videos variable if there is a match" do
      spiderman = Video.create(title: "Spiderman", description: "The spiderman movie")
      post :search, title: "spider"
      expect(assigns(:videos)).to eq([spiderman])
    end

    it "sets an empty @videos variable if there is no match" do
      post :search, title: "bat"
      expect(assigns(:vidoes)).to eq(nil)
    end
    
    it "renders the :search template" do
      post :search, title: "spider"
      response.should render_template :search
    end
  end

  # Don't have a user. -> redirect to root_path
  # We have a user:
    # GET SHOW
      # @video variable
      # Render _:show
    # POST SHOW
      # @videos variable with match and without bringing back results. 
      # Renders template
end