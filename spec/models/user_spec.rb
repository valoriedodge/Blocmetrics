require 'rails_helper'

RSpec.describe User, type: :model do
  #let(:user) { create(:user)}
  let(:user) { User.create!(email: "user@example.com", password: "password")}

  it { is_expected.to have_many(:registered_applications) }

  describe "attributes" do
    it "has an email and password"do
      expect(user).to have_attributes(email: user.email, password: user.password)
    end
  end

  describe "invalid user" do
      let(:user_with_invalid_email) { User.create(email: "", password: "password") }

      it "should be an invalid user due to blank email" do
          expect(user_with_invalid_email).to_not be_valid
      end

    end
end
