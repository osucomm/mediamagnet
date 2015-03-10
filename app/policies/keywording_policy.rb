class KeywordingPolicy < ApplicationPolicy

  def new?
    create?
  end

  def create?
    record.keywordable.has_user?(user) || user.admin?
  end

  def destroy?
    record.keywordable.has_user?(user) || user.admin?
  end

end
