require 'rails_helper'
require 'random_data'

RSpec.describe API::EventsController, type: :controller do

  #let(:user) { User.create!(email: "user@example.com", password: "password")}
  let(:application) { RegisteredApplication.create!(name: RandomData.random_name, url: RandomData.random_name)}

describe "POST create" do
  setup do
    @request.env['HTTP_REFERER'] = 'http://test.com/sessions/new'
    post :create, { :event => { :name => RandomData.name } }
  end

  #before do
  #  post :create, Origin: application.url, event: {name: RandomData.name}
  #end

  it "returns http success" do
    expect(response).to have_http_status(:success)
  end

  it "returns json content type" do
    expect(response.content_type).to eq 'application/json'
  end

  it "creates an event with the correct attributes" do
    hashed_json = JSON.parse(response.body)
    expect(hashed_json["name"]).to eq(event.name)
    expect(hashed_json["registered_application_id"]).to eq(application.id)
  end
end

end
