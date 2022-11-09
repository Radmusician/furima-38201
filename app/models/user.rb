class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,
  validates :email, uniqueness: true
  validates :last_name,
  validates :first_name,
  validates :last_name_kana,
  validates :first_name_kana,
  validates :birthday,

end
