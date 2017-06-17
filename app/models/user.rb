class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :email, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :messages
  has_many :groups_users
  has_many :groups, through: :groups_users
  scope :search_user, -> (keyword) { where('name LIKE(?)', "%#{ keyword }%") }
end
