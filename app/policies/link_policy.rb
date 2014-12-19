class LinkPolicy < ApplicationPolicy

  def index?
    user.dmin?
  end

end
