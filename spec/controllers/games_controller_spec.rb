require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      game = Game.create! valid_attributes
      get :index, {}, valid_session
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, {}, valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Game" do
        expect {
          post :create, {:game => valid_attributes}, valid_session
        }.to change(Game, :count).by(1)
      end

      it "redirects to the created game" do
        post :create, {:game => valid_attributes}, valid_session
        expect(response).to redirect_to(Game.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, {:game => invalid_attributes}, valid_session
        expect(response).to be_success
      end
    end
  end

end
