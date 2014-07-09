require 'spec_helper'

describe Api::PartsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/parts").to route_to("api/parts#index")
    end

    it "routes to #new" do
      expect(:get => "/api/parts/new").to route_to("api/parts#new")
    end

    it "routes to #show" do
      expect(:get => "/api/parts/1").to route_to("api/parts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/api/parts/1/edit").to route_to("api/parts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/api/parts").to route_to("api/parts#create")
    end

    it "routes to #update" do
      expect(:put => "/api/parts/1").to route_to("api/parts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/parts/1").to route_to("api/parts#destroy", :id => "1")
    end

  end
end
