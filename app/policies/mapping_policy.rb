class MappingPolicy < ApplicationPolicy

  def create?
    record.mappable.users.include?(user) || user.admin?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

end
