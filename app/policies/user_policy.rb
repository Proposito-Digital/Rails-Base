class UserPolicy < ApplicationPolicy
  def update_all_passwords?
    if user.admin?
      true
    else
      false
    end
  end
  def update_password?
    true
  end
  class Scope < Scope
        def resolve
            if user.admin?
                scope.all
            end
        end
    end
    def menu?
        user.admin?
    end
    def index?
        user.admin?
    end

    def show?
        user.admin?
    end

    def create?
        user.admin?
    end

    def new?
        user.admin?
    end

    def update?
        user.admin?
    end

    def edit?
        user.admin?
    end

    def destroy?
        user.admin?
    end
end
