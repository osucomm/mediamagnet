class Category < ActiveRecord::Base
  validates :name, format: { with: /\A[a-z]+\z/ }
  validates :name, uniqueness: true

  def to_param
    name
  end
end
