class EntityPolicy < ApplicationPolicy

  def new?
    true
  end

  def create?
    new?
  end
 
  def update?
    true
  end
end
