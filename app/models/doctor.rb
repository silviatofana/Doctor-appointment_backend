class Doctor < ApplicationRecord
  has_many :appointments
  has_many :users, through: :appointments
  validates :name, presence: true
  validates :specialization, presence: true
end
