class ItemPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def destroy?
    record.channel.has_user?(user) || user.admin?
  end

end
