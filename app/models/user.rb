class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :products

  devise :database_authenticatable, # :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: true }
  validates :token, uniqueness: true

  before_create :generate_authentication_token!

  def generate_authentication_token!
    begin
      self.token = Devise.friendly_token
    end while self.class.exists?(token: token)
  end
end
