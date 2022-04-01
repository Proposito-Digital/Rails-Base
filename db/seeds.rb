# frozen_string_literal: true

print(">>>> Creating Tenant \n")
dev_tenant = Tenant.find_or_create_by(name: "Develop", slug: "dev")

print(">>>> Createing Users\n ")
User.find_or_create_by(name: 'Develop', tenant: dev_tenant) do |user|
	user.email = 'dev@dev.com'
	user.password = 'test@123'
	user.current_role = UserRole.new_admin(user: user)
end

User.find_or_create_by(name: 'Teste', tenant: dev_tenant) do |user|
	user.email = 'test@test.com'
	user.password = 'test@123'
	user.current_role = UserRole.new_regular(user: user)
end
