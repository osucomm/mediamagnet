class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :entities

  def admin?
    email == 'butsko.7@osu.edu' || email == 'hinshaw.25@osu.edu'
  end

end
