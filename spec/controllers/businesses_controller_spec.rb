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
  end

  describe "POST create" do
    context "for authenticated users with valid inputs" do
      it "creates a business" do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        post :create, Fabricate.attributes_for(:business)
        expect(Business.count).to eq(1)
      end

      it "redirects to business show page"
    end

    context "for authenticated users with invalid inputs"

    it_behaves_like "requires sign in" do
      let(:action) { post :create, Fabricate.attributes_for(:business) }
    end
  end
end