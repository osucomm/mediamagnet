class TokenPolicy < ApplicationPolicy

  def index?
    user.is_admin?
  end

  def create?
    true
  end

  def destroy?
    user.is_admin?
  end

end
