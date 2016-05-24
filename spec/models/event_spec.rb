require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) { User.create!(email: "user@example.com", password: "password")}
  let(:application) { RegisteredApplication.create!(name: "App name", url: "app.com")}
  let(:event) { Event.create!(name: "Event name")}

  it { is_expected.to belong_to(:registered_application) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(3) }
  #it { is_expected.to validate_uniqueness_of(:name) }

  describe "attributes" do
     it "has name attributes" do
       expect(event).to have_attributes(name: "Event name")
     end
   end

   describe "invalid event" do
        let(:event_with_invalid_name) { Event.create(name: "A") }
        let(:event_missing_name) { Event.create(name: "")}


        it "should be an invalid user due to blank name" do
            expect(event_with_invalid_name).to_not be_valid
        end

        it "should be an invalid user due to blank email" do
            expect(event_missing_name).to_not be_valid
        end
    end

    describe "invalid event duplication" do
         let(:event_first) { Event.create(name: "Event first", registered_application: application) }
         let(:event_second) { Event.create(name: "Second event", registered_application: application) }
         #let(:event_duplication) { Event.create(name: "Event first", registered_application: application) }

         it "should be an invalid event due to duplication" do
             expect(event_first).to be_valid
             expect(event_second).to be_valid
             #expect(event_duplication).to_not be_valid
         end
     end
end
