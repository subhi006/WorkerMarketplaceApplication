FactoryBot.define do
  factory :task do
    salary { 10000 }
    company { "Bestpeers" }
    description { " Created a New Task" }
    location { "Bhopal" }
    category
    contractor { create(:user, role: "contractor") }
    status { :available }
    experience { 3 }
  end
end
