class UserRole < ApplicationRecord
	belongs_to :user, inverse_of: :roles

	validates_uniqueness_of :role, scope: :user_id

  enum role: { admin: 0, regular: 1 }

  def self.create_regular opts
		opts.merge!(role: UserRole.roles[:regular])
		self.create(opts)
	end

	def self.create_admin opts
		opts.merge!(role: UserRole.roles[:admin])
		self.create(opts)
	end

  def self.new_regular opts
		opts.merge!(role: UserRole.roles[:regular])
		self.new(opts)
	end

	def self.new_admin opts
		opts.merge!(role: UserRole.roles[:admin])
		self.new(opts)
	end

end
