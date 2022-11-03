class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :doctor
  validates :description, presence: true
  validates :date_of_appointment, presence: true
  validates :time_of_appointment, presence: true
  validates :user_id, presence: true
  validates :doctor_id, presence: true
end
