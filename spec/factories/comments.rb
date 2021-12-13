FactoryBot.define do
  factory :comment do
    body { "MyText" }
    profile { nil }
    headhunter { nil }
  end
end
