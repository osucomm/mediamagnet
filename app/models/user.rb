class User < ActiveRecord::Base

  # Associations
  has_many :identities, dependent: :destroy
  has_and_belongs_to_many :entities

  belongs_to :current_entity, class_name: 'Entity', foreign_key: 'current_entity_id'

  # Scopes
  default_scope -> {
    order('name ASC')
  }

  class << self
    def help_text
      <<-EOT
      Communicators who are authorized to make changes (add keywords and channels)
      in an Entity.
      EOT
    end
  end



  scope :admin, -> { where(admin: true) }

  def is_admin?
    admin
  end

  def display_name
    name || email
  end

  def sign_in!
    increment :sign_in_count
    self.last_sign_in_at = Time.now
    save
  end


  def self.create_with_omniauth(info)
    create(name: info['name'], email: info['email'])
  end

end
