class Category < ActiveRecord::Base
  validates :name, format: { with: /\A[a-z]+\z/ }
  validates :name, uniqueness: true
end
