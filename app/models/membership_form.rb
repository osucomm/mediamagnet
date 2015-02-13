class MembershipForm
  include ActiveModel::Model

  attr_accessor :id, :entity_id, :entity, :user_id, :user

  def entity
    Entity.find(entity_id)
  end

  def user
    User.find(user_id)
  end

  def destroy
    entity.users.delete(user)
  end

  def save
    entity = Entity.find(@entity_id)
    user = User.find(@user_id)
    entity.users << user unless entity.has_user?(user)
  end

end
