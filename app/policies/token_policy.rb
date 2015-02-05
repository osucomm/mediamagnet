class TokenPolicy < ApplicationPolicy

  def index?
    create?
  end

  def create?
    user.is_admin?
  end

end
