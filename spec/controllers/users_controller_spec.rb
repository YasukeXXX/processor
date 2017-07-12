require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "#edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "#show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end
end
