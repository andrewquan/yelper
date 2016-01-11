require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "creates a user" do
        expect(User.count).to eq(1)
      end

      it "redirects to home page" do
        expect(response).to redirect_to sign_in_path
      end

      it "sets the flash notice" do
        expect(flash[:notice]).not_to be_blank
      end
    end

    context "with invalid inputs" do
      before { post :create, user: { email: Faker::Internet.email, password: 'password' } }

      it "does not create a user" do
        expect(User.count).to eq(0)
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end

  describe "GET show" do
    it "sets @user" do
      get :show
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
end