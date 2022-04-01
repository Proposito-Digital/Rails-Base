FactoryBot.define do
  factory :user_role do
    user { create :user_regular }
    role { UserRole.roles[:regular] }
  end
end
