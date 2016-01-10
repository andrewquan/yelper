require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    let(:alice) { Fabricate(:user) }
    let(:business) { Fabricate(:business) }
    before { session[:user_id] = alice.id }

    context "with valid inputs" do
      it "creates a review on the business" do
        post :create, review: Fabricate.attributes_for(:review), business_id: business.id, user_id: alice.id
        expect(Review.count).to eq(1)
      end

      it "creates a review associated with the current user" do
        post :create, review: Fabricate.attributes_for(:review), business_id: business.id, user_id: alice.id
        expect(Review.first.user).to eq(alice)
      end

      it "redirects to the business page" do
        post :create, review: Fabricate.attributes_for(:review), business_id: business.id, user_id: alice.id
        expect(response).to redirect_to business_path(business)
      end

      it "sets the flash notice" do
        post :create, review: Fabricate.attributes_for(:review), business_id: business.id, user_id: alice.id
        expect(flash[:notice]).not_to be_blank
      end
    end

    context "with invalid inputs" do
      it "does not create a review associated to the business" do
        post :create, review: { content: ""}, business_id: business.id, user_id: alice.id
        expect(Review.count).to eq(0)
      end

      it "renders the business/show template" do
        post :create, review: { content: ""}, business_id: business.id, user_id: alice.id
        expect(response).to render_template 'businesses/show'
      end

      it "sets @business" do
        post :create, review: { content: ""}, business_id: business.id, user_id: alice.id
        expect(assigns(:business)).to eq(business)
      end

      it "sets the flash error" do
        post :create, review: { content: ""}, business_id: business.id, user_id: alice.id
        expect(flash[:error]).not_to be_blank
      end
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :create, review: Fabricate.attributes_for(:review), business_id: business.id }
    end
  end
end