require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    context "with authenticated user" do
      it "renders the index template" do
        set_current_user
        get :index
        expect(response).to render_template :index
      end
      it "sets the @queue_items variable" do
        user = Fabricate(:user)
        set_current_user(user)
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item, video: video, user: user)
        get :index
        expect(assigns(:queue_items)).to eq([queue_item])
      end
      it "orders the @queue_items by position ASC" do
        user = Fabricate(:user)
        set_current_user(user)
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, video: video1, user: user, position: 1)
        queue_item2 = Fabricate(:queue_item, video: video1, user: user, position: 2)
        get :index
        expect(assigns(:queue_items)).to start_with([queue_item1,queue_item2])
      end
    end
    context "with unauthenticated user" do
      it_behaves_like "requires sign in" do
        let(:action) { get :index }

      end
    end
  end

  describe "POST create" do
    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end
    it "redirects to my_queue path for authenticated user" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end
    it "creates the queue item" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to be(1)
    end
    it "creates the queue item that is associated with the video" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end
    it "creates the queue item that is associated with the sign in user" do
      user = Fabricate(:user)
      set_current_user(user)
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(user)
    end
    it "puts the video as last one in the queue" do
      user = Fabricate(:user)
      set_current_user(user)
      monk = Fabricate(:video, title: "Monk")
      Fabricate(:queue_item, video: monk, user: user)
      futurama = Fabricate(:video, title: "Futurama")
      post :create, video_id: futurama.id
      futurama_queue_item = QueueItem.where(video_id: futurama.id, user_id: user.id).first
      expect(futurama_queue_item.position).to eq(2)
    end
    it "does not add the video to the queue if the video is already in the queue" do
      user = Fabricate(:user)
      set_current_user(user)
      monk = Fabricate(:video, title: "Monk")
      Fabricate(:queue_item, video: monk)
      post :create, video_id: monk.id
      expect(user.queue_items.count).to eq(1)
    end
  end

  describe "GET destroy" do
    it "redirects to the my queue page" do
      set_current_user
      queue_item = Fabricate(:queue_item)
      get :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end
    it "deletes the queue_item" do
      user = Fabricate(:user)
      set_current_user(user)
      queue_item = Fabricate(:queue_item, user: user)
      get :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end
    it "does not delete the queue item if queue item is not in the current user's queueu" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      set_current_user(bob)
      queue_item = Fabricate(:queue_item, user: alice)
      get :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end
    it_behaves_like "requires sign in" do
      let(:action) { get :destroy, id: 1 }
    end
    it "normalizes the remaining queu items" do
      alice = Fabricate(:user)
      set_current_user(alice)
      queue_item1 = Fabricate(:queue_item, user: alice, position: 1)
      queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
      get :destroy, id: queue_item1.id
      expect(queue_item2.reload.position).to eq(1)
    end
  end

  describe "POST update_queue" do
    it_behaves_like "requires sign in" do
      let(:action) { post :update_queue, queue_items: [{id: 1, position: 1}] }
    end
    
    context "with valid input" do
    
      let(:alice) { Fabricate(:user) }
      let(:video1) { Fabricate(:video) }
      let(:video2) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: alice, position: 1, video: video1) }
      let(:queue_item2) { Fabricate(:queue_item, user: alice, position: 2, video: video2) }
    
      before { set_current_user(alice) }
    
      it "redirects back to the my queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it "reorders the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(alice.queue_items).to eq([queue_item2,queue_item1])
      end
      it "normalises the position numbers" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 4}]
        expect(alice.queue_items.map(&:position)).to eq([1,2])
      end 
    end
    
    context "with invalid input" do

      let(:alice) { Fabricate(:user) }
      let(:video1) { Fabricate(:video) }
      let(:video2) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: alice, position: 1, video: video1) }
      let(:queue_item2) { Fabricate(:queue_item, user: alice, position: 2, video: video2) }

      before { set_current_user(alice) }

      it "redirects to the my queueu page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 4}]
        expect(response).to redirect_to my_queue_path
      end
      it "sets the flash error message" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 4}]
        expect(flash[:error]).to be_present
      end
      it "does not change the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 4}, {id: queue_item2.id, position: 4.5}]
        expect(alice.queue_items).to eq([queue_item1, queue_item2])
      end
    end

    context "with queue items that do not belong to the current user" do
      it "does not change the queue items" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        set_current_user(alice)
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: alice, position: 1, video: video1)
        queue_item2 = Fabricate(:queue_item, user: bob, position: 2, video: video2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 1}, {id: queue_item2.id, position: 4}]
        expect(queue_item2.reload.position).to eq(2)
      end
    end
  end
end