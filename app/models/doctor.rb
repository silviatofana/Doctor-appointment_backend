class Doctor < ApplicationRecord
  has_many :appointments
  has_many :users, through: :appointments
  validates :name, presence: true
  validates :gender, presence: true
  validates :specialization, presence: true

  def default_values
    self.picture = if gender == 'M' || gender == 'Male'
                     'male-placeholder.png'
                   else
                     'female-placeholder.png'
                   end
    picture
  end
end
