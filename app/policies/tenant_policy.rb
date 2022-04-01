class TenantPolicy < ApplicationPolicy
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

    def change_current_tenant?
        user.admin?
    end

    def disable_current_tenant?
        user.admin?
    end

end
  