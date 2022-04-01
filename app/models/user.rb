# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_tenant(:tenant,  has_global_records: true)

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  belongs_to :current_role, class_name: "UserRole", optional: true
  has_many :roles, class_name: "UserRole", inverse_of: :user, dependent: :destroy

  validates_presence_of :name
  before_validation :_before_validate_create, on: [:create]

  def destroy
    self.update current_role: nil
    super
  end

  def access_token_expired?
    self.token_expiration_time + 2.hours <= DateTime.now.in_time_zone
  end

  def role
    self.current_role
  end

  def active_for_authentication?
    super && !discarded?
  end

  def _before_validate_create
    self.set_new_tenant
  end

  def admin!
    unless self.any_role_is_admin?
      self.update current_role: (UserRole.create_admin user: self)
    else
      self.update current_role: self.roles.find_by(role: :admin)
    end
  end

  def regular!
    unless self.any_role_is_regular?
      self.update current_role: (UserRole.create_regular user: self)
    else
      self.update current_role: self.roles.find_by(role: :regular)
    end
  end

  def admin?
    self.current_role ?
      self.current_role.admin?
    : false
  end

  def regular?
    self.current_role ?
      self.current_role.regular?
    : false
  end

  def any_role_is_admin?
    self.any_role_is? :admin
  end

  def any_role_is_regular?
    self.any_role_is? :regular
  end

  protected

  def set_new_tenant
    unless self.tenant_id.present?
      tenant = Tenant.create(name: self.name)
      self.tenant_id = tenant.id
    end
  end

  def set_current_role
    unless self.current_role.present?
      self.current_role = self.roles.first
    end
  end

  def any_role_is? role
    self.roles.where(role: role).any?
  end

end
