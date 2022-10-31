require 'rails_helper'

RSpec.describe 'Appointments', type: %w[request feature] do
  before do
    post '/api/v1/users',
         params: { name: 'Solo Boss', password: '123456', password_confirmation: '123456', email: 'boss@gmail.com',
                   role: 'admin' }
    @user = User.all.last

    post '/auth/login', params: { email: @user.email, password: '123456' }
    @token = JSON.parse(response.body)['token']

    post '/api/v1/doctors',
         params: { doctor: { name: 'Solo Boss', specialization: 'Oncologist', picture: 'http://localhost/pic.png' } },
         headers: { Authorization: @token }

    @doctor = Doctor.all.last

    post "/api/v1/doctors/#{@doctor.id}/appointments",
         params: { appointment: { date_of_appointment: '2022-10-26', doctor_id: @doctor.id, user_id: @user.id,
                                  time_of_appointment: '10:30 AM', description: 'Having Migrains' } },
         headers: { Authorization: @token }

    @appointment = Doctor.find(@doctor.id).appointments.all.last
  end

  it 'renders the doctors appointments list' do
    get "/api/v1/doctors/#{@doctor.id}/appointments"
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body).size).to eq(1)
  end

  it 'renders the requested appointment' do
    get "/api/v1/doctors/#{@doctor.id}/appointments/#{@appointment.id}"
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['date_of_appointment']).to eq('2022-10-26')
    expect(JSON.parse(response.body)['description']).to eq('Having Migrains')
  end

  it 'updates a appointment' do
    new_appointment = { appointment: { date_of_appointment: '2022-10-27', doctor: @doctor, user: @user,
                                       time_of_appointment: '12:30 PM', description: 'Having Migrains' } }
    put "/api/v1/doctors/#{@doctor.id}/appointments/#{@appointment.id}", params: new_appointment,
                                                                         headers: { Authorization: @token }
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['date_of_appointment']).to eq('2022-10-27')
  end

  it 'deletes an appointment doctor' do
    delete "/api/v1/doctors/#{@doctor.id}/appointments/#{@appointment.id}", headers: { Authorization: @token }
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body).size).to eq(0)
  end
end
