class MappingPolicy < ApplicationPolicy

  def new?
    record.mappable.has_user?(user) || user.admin?
  end

  def create?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end

end
