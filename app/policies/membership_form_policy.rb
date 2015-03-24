class MembershipFormPolicy < ApplicationPolicy

  def new?
    create?
  end

  def create?
    record.entity.has_user?(user) || user.admin?
  end

  def destroy?
    create?
  end

end
