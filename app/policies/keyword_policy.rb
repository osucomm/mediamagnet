class KeywordPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.is_admin?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

end
