class EntityPolicy < ApplicationPolicy

  def new?
    true
  end

  def create?
    new?
  end
 
  def update?
    record.has_user? user
  end

  def destroy?
    user.is_admin?
  end
end
