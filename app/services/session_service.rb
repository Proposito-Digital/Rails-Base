class SessionService
  attr_accessor :session

  def initialize(request)
    self.session = request.session
  end

  def set_admin_tenant_id(value)
    self.session[:admin_tenant_id] = value
  end

  def admin_tenant_id
    return self.session[:admin_tenant_id]
  end

  def clear_admin_tenant_id
    self.session[:admin_tenant_id] = nil
  end
end