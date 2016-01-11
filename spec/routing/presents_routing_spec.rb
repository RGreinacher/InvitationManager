require "rails_helper"

RSpec.describe PresentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/presents").to route_to("presents#index")
    end

    it "routes to #new" do
      expect(:get => "/presents/new").to route_to("presents#new")
    end

    it "routes to #show" do
      expect(:get => "/presents/1").to route_to("presents#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/presents/1/edit").to route_to("presents#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/presents").to route_to("presents#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/presents/1").to route_to("presents#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/presents/1").to route_to("presents#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/presents/1").to route_to("presents#destroy", :id => "1")
    end

  end
end
