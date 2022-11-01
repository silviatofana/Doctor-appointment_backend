require 'rails_helper'

RSpec.describe Doctor, type: :model do
  subject do
    user = User.create(name: 'Solo Boss', password: '123456', email: 'soloboss@gmail.com', role: 'admin')
    Doctor.new(name: 'Silvia', picture: 'https://icon.com/icon.jpg', specialization: 'Cardiologist', gender: 'F')
  end

  before { subject.save }

  context 'Test for validation : ' do
    it 'Name should be valid' do
      expect(subject).to be_valid
    end

    it 'Name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'Specialization should be present' do
      subject.specialization = nil
      expect(subject).to_not be_valid
    end
  end
end
