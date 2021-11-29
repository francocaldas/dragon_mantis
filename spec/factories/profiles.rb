FactoryBot.define do
  factory :profile do
    name { "MyString" }
    social_name { "MyString" }
    birth_date { "" }
    formation { "MyString" }
    description { "" }
    experience { "" }
    photo { "MyString" }
    user { nil }
  end
end
