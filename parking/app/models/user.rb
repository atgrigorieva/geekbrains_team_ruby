class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login]
  # attr_accessor :login

  belongs_to :role

  def email_required?
    false    
  end

  def email_changed?
    false    
  end
end
