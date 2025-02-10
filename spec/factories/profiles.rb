FactoryBot.define do
  factory :profile do
    user
    name { "MyString" }
    bio { "MyText" }
    contact_info { "MyString" }
    address { "MyString" }
    avatar { "MyString" }
  end
end
