require 'spec_helper'

describe "Contacts", :type => :request do
  describe "GET /contacts" do
    it "works! (now write some real specs)" do
      get contacts_path
      expect(response.status).to be(200)
    end
  end
end
