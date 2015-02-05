class EntityMailer < ApplicationMailer
  def register_email(entity)
    @entity = entity
    @users = @entity.users.pluck(:email).join(', ')
    mail(to: User.admin.pluck(:email), subject: '[Media Magnet] Entity registration')
  end
end
