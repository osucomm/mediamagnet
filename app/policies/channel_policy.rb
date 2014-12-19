class ChannelPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    record.entity.has_user? user
  end

  def new?
    create?
  end

  def update?
    create?
  end

  def destroy?
    user.is_admin?
  end

end
