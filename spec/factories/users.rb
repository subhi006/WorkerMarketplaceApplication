FactoryBot.define do
  factory :user do
    first_name { "Sakshi" }
    last_name { "Mishra" }
    email { "mishrasakshi309@gmail.com" }
    phone_number { 6261552905 }
    password { "Sakshi01" }
    role { :worker }

    after(:create) do |user|
      create(:profile, user: user)
      create(:task, contractor: user)
    end
 end
end
