require "rails_helper"

RSpec.describe Api::ClientsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/clients").to route_to("api/clients#index")
    end

    it "routes to #new" do
      expect(:get => "/api/clients/new").to route_to("api/clients#new")
    end

    it "routes to #show" do
      expect(:get => "/api/clients/1").to route_to("api/clients#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/api/clients/1/edit").to route_to("api/clients#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/api/clients").to route_to("api/clients#create")
    end

    it "routes to #update" do
      expect(:put => "/api/clients/1").to route_to("api/clients#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/clients/1").to route_to("api/clients#destroy", :id => "1")
    end

  end
end
