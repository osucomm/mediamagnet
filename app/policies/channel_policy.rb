class ChannelPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    record.approved? || User.exists?(user)
  end

  def create?
    record.entity.has_user?(user) || user.is_admin?
  end

  def new?
    create?
  end

  def update?
    create?
  end

  def destroy?
    record.entity.has_user?(user) || user.is_admin?
  end

  def refresh?
    user.is_admin?
  end

  def transfer?
    user.is_admin?
  end

  def permitted_attributes
    permitted = [:name, :description, :service_identifier, :url, :avatar_url, :primary,
        :keyword_ids => [], contact_attributes: [:id, :name, :organization, :url, :phone, :email]]

    transfer? ? (permitted << :entity_id) : permitted
  end


end
