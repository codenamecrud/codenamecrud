class User < ActiveRecord::Base
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable

  has_many :lesson_users
  has_many :lessons, through: :lesson_users
end
