class TokenPolicy < ApplicationPolicy

  def index?
    create?
  end

  def create?
    true
  end

  def destroy?
    user.is_admin?
  end

end
