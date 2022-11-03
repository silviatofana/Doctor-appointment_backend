class User < ApplicationRecord
  has_many :appointments
  has_many :doctors, through: :appointments
  before_validation :default_values
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true

  def default_values
    self.role = 'normal' if role.nil?
  end
end
