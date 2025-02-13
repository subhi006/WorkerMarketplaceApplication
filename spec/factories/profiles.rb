FactoryBot.define do
  factory :profile do
    user
    name { "Subhi" }
    bio { "Ruby Developer" }
    contact_info { "123456789" }
    address { "Indore" }
    avatar { "MyString" }
  end
end
