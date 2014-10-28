class ChannelPolicy < ApplicationPolicy

  def create?
    record.entity.has_user? user
  end
 
  def update?
    create?
  end

  def destroy?
    user.is_admin?
  end

end
