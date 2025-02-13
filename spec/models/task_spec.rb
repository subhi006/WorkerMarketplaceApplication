require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { FactoryBot.build(:task) }
  describe "Validations" do
    context "should validate" do
      it "with salary, company, description, location, experience and category" do
        expect(task).to be_valid
      end
    end

    context "should not validate" do
      it "when salary is not present" do
        task.salary = nil
        expect(task).not_to be_valid
      end

      it "when company is not present" do
        task.company = nil
        expect(task).not_to be_valid
      end

      it "when description is not present" do
        task.description = nil
        expect(task).not_to be_valid
      end

      it "when location is not present" do
        task.location = nil
        expect(task).not_to be_valid
      end

      it "when category is not present" do
        task.category = nil
        expect(task).not_to be_valid
      end

      it "when salary is not greater than 0" do
        task.salary = -5
        expect(task).not_to be_valid
      end

      it "when experience is not 0 or geater than 0" do
        task.experience = -3
        expect(task).not_to be_valid
      end
    end
  end
end
