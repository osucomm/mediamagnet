class MoveUserDataToIdentitiesTable < ActiveRecord::Migration
  def change
    if User.reflect_on_association(:identities)
      User.find_each do |user|
         user.identities.create(
           :uid => user.username,
           :provider => 'shibboleth'
         )
      end
    end
  end
end
