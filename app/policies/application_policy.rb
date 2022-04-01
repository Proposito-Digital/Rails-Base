class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "Por favor faça o login" unless user
    @user = user
    @record = record
  end

  def menu?
    true
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    true
  end

  def edit?
    update?
  end

  def destroy?
    true
  end

  class Scope
    attr_reader :user, :scope, :instances

    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, "Por favor faça o login" unless user
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
