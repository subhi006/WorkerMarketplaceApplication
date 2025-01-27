FactoryBot.define do
  factory :profile do
    user { nil }
    name { "MyString" }
    bio { "MyText" }
    contact_info { "MyString" }
    address { "MyString" }
    avatar { "MyString" }
  end
end
