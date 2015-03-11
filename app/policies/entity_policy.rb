class EntityPolicy < ApplicationPolicy

  def new?
    true
  end

  def show?
    record.approved? || User.exists?(user)
  end

  def create?
    new?
  end
 
  def update?
    user && record.has_user?(user) || user.is_admin?
  end

  def join?
    user.entities.exclude? record
  end

  def destroy?
    user.is_admin?
  end

  def approve?
    user.is_admin?
  end

  def permitted_attributes
    permitted = [:name, :description, :link, :keyword_ids => [],
      contact_attributes: [:id, :name, :organization, :url, :phone, :email],
      user_ids: []]

    approve? ? permitted << :approved : permitted
  end
end
