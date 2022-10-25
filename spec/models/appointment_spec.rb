require 'rails_helper'

RSpec.describe Appointment, type: :model do
  subject do
    user = User.create(name: 'Solo Boss', password: '123456', email: 'soloboss@gmail.com')
    doctor = Doctor.create(name: 'Silvia', picture: 'https://icon.com/icon.jpg', specialization: 'Cardiologist')
    Appointment.new(description: 'head ache', user:, doctor:, date_of_appointment: '2021-01-01',
                    time_of_appointment: '10:00')
  end

  before { subject.save }

  context 'Test for validation : ' do
    it 'Appointment should be valid' do
      expect(subject).to be_valid
    end

    it 'Description should be present' do
      subject.description = nil
      expect(subject).to_not be_valid
    end

    it 'Appointment_dates should be present' do
      subject.date_of_appointment = nil
      expect(subject).to_not be_valid
    end

    it 'Appointment_time should be present' do
      subject.time_of_appointment = nil
      expect(subject).to_not be_valid
    end

    it 'Appointment_user should be present' do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end

    it 'Appointment_doctor should be present' do
      subject.doctor_id = nil
      expect(subject).to_not be_valid
    end
  end
end
