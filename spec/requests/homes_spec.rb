require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "#index" do
    before { get root_path }
    it { expect(response).to have_http_status(200) }
  end
end
