require 'rails_helper'

RSpec.describe RegisteredApplication, type: :model do
  let(:user) { User.create!(email: "user@example.com", password: "password")}
  let(:application) { RegisteredApplication.create!(name: "App name", url: "app.com")}

  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(3) }

  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_uniqueness_of(:url) }
  it { is_expected.to validate_length_of(:url).is_at_least(3) }

  describe "attributes" do
     it "has name and url attributes" do
       expect(application).to have_attributes(name: "App name", url: "app.com")
     end
   end

   describe "invalid registered_application" do
        let(:application_with_invalid_name) { RegisteredApplication.create(name: "A", url: "app.com") }
        let(:application_with_invalid_url) { RegisteredApplication.create(name: "App name", url: "a") }


        it "should be an invalid user due to blank name" do
            expect(application_with_invalid_name).to_not be_valid
        end

        it "should be an invalid user due to blank email" do
            expect(application_with_invalid_url).to_not be_valid
        end
    end

    describe "invalid registered_application duplication" do
         let(:application_first) { RegisteredApplication.create(name: "App name", url: "app.com", user: user) }
         let(:application_duplication) { RegisteredApplication.create(name: "App name", url: "app.com", user: user) }

         it "should be an invalid application due duplication" do
             expect(application_first).to be_valid
             expect(application_duplication).to_not be_valid
         end
     end

end
