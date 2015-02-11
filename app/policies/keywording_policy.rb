class KeywordingPolicy < ApplicationPolicy

  def new?
    create?
  end

  def create?
    record.keywordable.has_user?(user)
  end

  def destroy?
    record.keywordable.has_user?(user)
  end

end
