class EntitiesUsers < ActiveRecord::Base
  belongs_to :entity
  belongs_to :user
end
