class MappingPolicy < ApplicationPolicy

  def create?
    record.mappable.has_user? user
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

end
