class LinkPolicy < ApplicationPolicy

  def index?
    user.is_admin?
  end

end
