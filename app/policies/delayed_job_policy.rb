class DelayedJobPolicy < Struct.new(:user, :delayed_job)

  def index?
    user.admin?
  end
  def destroy?
    user.admin?
  end


end


