class UserPolicy < ApplicationPolicy

  def index?
    create?
  end

  def show?
    create?
  end

  def new?
    create?
  end

  def create?
    user.is_admin?
  end

  def edit?
    record != user && user.admin?
  end

  def update?
    edit?
  end

  def destroy?
    create?
  end
end
