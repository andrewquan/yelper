require 'spec_helper'

describe BusinessesController do
  describe "GET index" do
    it "sets @businesses" do
      business1 = Fabricate(:business)
      business2 = Fabricate(:business)
      get :index
      expect(assigns(:businesses)).to match_array([business1, business2])
    end
  end

  describe "GET show" do
    it "sets @business" do
      business = Fabricate(:business)
      get :show, id: business.id
      expect(assigns(:business)).to eq(business)
    end

    it "sets @review" do
      business = Fabricate(:business)
      get :show, id: business.id
      expect(assigns(:review)).to be_instance_of(Review)
    end
  end

  describe "POST create" do
    context "for authenticated users" do
      let(:alice) { Fabricate(:user) }
      before { session[:user_id] = alice.id }

      context "with valid inputs" do
        it "creates a business" do
          post :create, business: Fabricate.attributes_for(:business)
          expect(Business.count).to eq(1)
        end

        it "sets the flash notice" do
          post :create, business: Fabricate.attributes_for(:business)
          expect(flash[:notice]).not_to be_blank
        end

        it "redirects to home path" do
          post :create, business: Fabricate.attributes_for(:business)
          expect(response).to redirect_to home_path
        end
      end

      context "with invalid inputs" do
        it "does not create a business" do
          post :create, business: { name: "Starbucks", image_url: "/tmp/starbucks.jpg" }
          expect(Business.count).to eq(0)
        end

        it "renders the new template" do
          post :create, business: { name: "Starbucks", image_url: "/tmp/starbucks.jpg" }
          expect(response).to render_template :new
        end

        it "sets @business" do
          post :create, business: { name: "Starbucks", image_url: "/tmp/starbucks.jpg" }
          expect(assigns(:business)).to be_instance_of(Business)
        end
      end
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :create, Fabricate.attributes_for(:business) }
    end
  end

  describe "POST search" do
    it "sets @results" do
      business1 = Fabricate(:business, name: "Chipotle")
      business2 = Fabricate(:business, name: "Potluck")
      post :search, search_term: 'pot'
      expect(assigns(:results)).to match_array([business1, business2])
    end
  end
end