# frozen_string_literal: true

FactoryBot.define do

  factory :user do  
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'teste@123' }
    password_confirmation { 'teste@123' }
    token_expiration_time { DateTime.now.in_time_zone }
    tenant { create :tenant }
    after(:create) do |user, evaluator|
      user.regular!
    end
  end

  factory :user_admin, class: :user do  
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'teste@123' }
    password_confirmation { 'teste@123' }
    token_expiration_time { DateTime.now.in_time_zone }
    tenant { nil }
    after(:create) do |user, evaluator|
      user.admin!
    end
  end

end