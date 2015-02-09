class DelayedJobPolicy < Struct.new(:user, :delayed_job)

  def index?
    user.is_admin?
  end
  def destroy?
    user.is_admin?
  end


end


