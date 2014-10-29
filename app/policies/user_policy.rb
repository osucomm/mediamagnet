class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def show?
    user.admin?
  end

  def new?
    user.admin?
  end

  def create?
    new?
  end

  def edit?
    edit?
  end

  def update?
    edit?
  end

  def destroy?
    user.admin?
  end
end
