require 'rails_helper'
require 'random_data'

RSpec.describe API::EventsController, type: :controller do

  let(:user) { User.create!(email: "user@example.com", password: "password")}
  let(:application) { RegisteredApplication.create!(name: RandomData.random_name, url: RandomData.random_name, user: user)}

describe "POST create" do
  context "with valid attributes" do
    before do
      request.env['HTTP_ORIGIN'] = application.url
      @event = Event.new(name: "My Event")
      post :create, event: { name: @event.name }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns json content type" do
      expect(response.content_type).to eq 'application/json'
    end

    it "creates an event with the correct attributes" do
      hashed_json = JSON.parse(response.body)
      expect(hashed_json["name"]).to eq(@event.name)
      expect(hashed_json["registered_application_id"]).to eq(application.id)
    end
  end

  context "with invalid application url" do
    before do
      request.env['HTTP_ORIGIN'] = "my.url"
      @event = Event.new(name: "My Event")
      post :create, event: { name: @event.name }
    end

    it "returns http :unprocessable_entity" do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns json content type" do
      expect(response.content_type).to eq 'application/json'
    end
  end

  context "with invalid attributes" do
    before do
      request.env['HTTP_ORIGIN'] = application.url
      #@event = Event.new(name: "")
      post :create, event: { name: "" }
    end

    it "returns http :unprocessable_entity" do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns json content type" do
      expect(response.content_type).to eq 'application/json'
    end
  end
 end

end
