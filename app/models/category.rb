class Category < ActiveRecord::Base
  validates :name, format: { with: /\A[a-z]+\z/ }
end
