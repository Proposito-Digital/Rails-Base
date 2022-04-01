FactoryBot.define do
  factory :tenant do
    name { Faker::Name.name }
    slug { Faker::Name.unique.initials }
    deleted_at { nil }
  end
end
