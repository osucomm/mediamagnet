class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_and_belongs_to_many :entities

  # Scopes
  default_scope -> {
    order('email ASC')
  }

  def is_admin?
    admin
  end

  def display_name
    fullname || username
  end

end
