class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:shibboleth]

  # Associations
  has_and_belongs_to_many :entities

  belongs_to :current_entity, class_name: 'Entity', foreign_key: 'current_entity_id'

  # Scopes
  default_scope -> {
    order('email ASC')
  }

  scope :admin, -> { where(admin: true) }

  def is_admin?
    admin
  end

  def display_name
    fullname || username
  end


  def self.from_omniauth(auth_hash)
    where(username: auth_hash[:uid]).first_or_initialize.tap do |user|
      user.update_attributes Hash[auth_hash[:info].select{|k,_| user.respond_to? "#{k}="}]
      user.password = Devise.friendly_token[0,20]
      user.save!
    end
  end

end
