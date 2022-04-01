class DashboardPolicy < Struct.new(:user, :dashboard)
  def menu?
    true
  end
  def index?
    true
  end
end
