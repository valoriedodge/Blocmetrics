require 'rails_helper'
require 'random_data'

RSpec.describe RegisteredApplicationsController, type: :controller do
  let(:user) { User.create!(email: "user@example.com", password: "password")}
  let(:application) { RegisteredApplication.create!(name: RandomData.random_name, url: RandomData.random_name, user: user)}
  let(:other_application) { RegisteredApplication.create!(name: RandomData.random_name, url: RandomData.random_name)}

  context "Signed in user"
    before do
        @user = user
        @user.confirmed_at = Time.zone.now
        @user.save
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @user
    end

  describe "GET index" do
          it "returns http success" do
              get :index
              expect(response).to have_http_status(:success)
          end

          it "assigns RegisteredApplication.all to registered_application" do
              get :index
              expect(assigns(:registered_applications)).to eq([application])
          end

          it "does not include applications of other users in @registered_applications" do
              get :index
              expect(assigns(:registered_applications)).not_to include(other_application)
          end
      end

      describe "GET show" do
          it "returns http success" do
              get :show, {id: application.id}
              expect(response).to have_http_status(:success)
          end

          it "renders the #show view" do
              get :show, {id: application.id}
              expect(response).to render_template :show
          end

          it "assigns application to @registered_application" do
              get :show, {id: application.id}
              expect(assigns(:registered_application)).to eq(application)
          end
      end

      describe "GET #new" do
        it "returns http success" do
            get :new
            expect(response).to have_http_status(:success)
        end

        it "renders the #new view" do
          get :new
          expect(response).to render_template :new
        end

        it "initializes @registered_application" do
          expect(assigns(:registered_application)).to be_nil
          get :new
          expect(assigns(:registered_application)).not_to be_nil
        end
      end

    describe "POST #create" do
      it "increases the number of registered applications by 1" do
        expect{post :create, registered_application: {name: RandomData.random_name, url: RandomData.random_name} }.to change(RegisteredApplication,:count).by(1)
      end

      it "assigns RegisteredApplication.last to @registered_application" do
        post :create, registered_application: {name: RandomData.random_name, url: RandomData.random_name}
        expect(assigns(:registered_application)).to eq RegisteredApplication.last
      end

      it "redirects to the new application" do
        post :create, registered_application: {name: RandomData.random_name, url: RandomData.random_name}
        expect(response).to redirect_to RegisteredApplication.last
      end
    end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, id: application.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, id: application.id
      expect(response).to render_template :edit
    end

    it "assigns application to be updated to @registered_application" do
      get :edit, {id: application.id}
      application_instance = assigns(:registered_application)

      expect(application_instance.id).to eq application.id
      expect(application_instance.name).to eq application.name
      expect(application_instance.url).to eq application.url
    end
  end

  describe "PUT #update" do
    it "updates application with expected attributes" do
      new_name = RandomData.random_name
      new_url = RandomData.random_name

      put :update, id: application.id, registered_application: {name: new_name, url: new_url}

      updated_application = assigns(:registered_application)
      expect(updated_application.id).to eq application.id
      expect(updated_application.name).to eq new_name
      expect(updated_application.url).to eq new_url
    end

    it "redirects to the updated application" do
      new_name = RandomData.random_name
      new_url = RandomData.random_name

      put :update, id: application.id, registered_application: {name: new_name, url: new_url}
      expect(response).to redirect_to(:registered_application)
    end
  end

  describe "DELETE destroy" do
    it "deletes the application" do
      count = RegisteredApplication.where(id: application.id).size
      expect(count).to eq(1)
      delete :destroy, id: application.id
      count2 = RegisteredApplication.where(id: application.id).size
      expect(count2).to eq(0)
    end

    it "redirects to the index view" do
      delete :destroy, id: application.id
      expect(response).to redirect_to registered_applications_path
    end
  end

end
