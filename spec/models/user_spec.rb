require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  context "should validate" do
    it "with first_name, last_name, phone_number, email, password, role" do
      expect(user).to be_valid
    end
  end

  context "should not validate" do
    it "when first_name is not present" do
      user.first_name = nil
      expect(user).not_to be_valid
    end

    it "when last_name is not present" do
      user.last_name = nil
      expect(user).not_to be_valid
    end

    it "when email is not present" do
      user.email = nil
      expect(user).not_to be_valid
    end

    it "when password is not present" do
      user.password = nil
      expect(user).not_to be_valid
    end

    it "when phone_number is not present" do
      user.phone_number = nil
      expect(user).not_to be_valid
    end

    it "when role is not present" do
      user.role = nil
      expect(user).not_to be_valid
    end
  end

  describe "full_name" do
  it "returns the correct full name" do
    user.first_name = "Sakshi"
    user.last_name = "Mishra"
    expect(user.full_name).to eq("Sakshi Mishra")
  end
end
end
