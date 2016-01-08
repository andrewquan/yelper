require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end

    it "redirects to the home page for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    let(:alice) { Fabricate(:user) }

    context "with valid credentials" do
      before { post :create, email: alice.email, password: alice.password }

      it "sets the session" do
        expect(session[:user_id]).to eq(alice.id)
      end
      
      it "redirects the signed in user to the home page" do
        expect(response).to redirect_to home_path
      end

      it "sets the flash notice" do
        expect(flash[:notice]).not_to be_blank
      end
    end

    context "with invalid credentials" do
      before { post :create, email: alice.email, password: "password1234" }
      
      it "does not set the session" do        
        expect(session[:user_id]).to be_nil
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end

      it "sets the flash error" do
        expect(flash[:error]).not_to be_blank
      end
    end
  end

  describe "DELETE destroy" do
    it "removes the user from the session" do
      delete :destroy
      expect(session[:user_id]).to be_nil
    end
    
    it "redirects to the home page" do
      delete :destroy
      expect(response).to redirect_to home_path
    end
  end
end