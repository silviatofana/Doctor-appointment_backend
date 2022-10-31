require 'rails_helper'

RSpec.describe 'Doctors', type: %w[request feature] do
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
  end

  it 'renders the doctors list' do
    get '/api/v1/doctors/'
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body).size).to eq(1)
  end

  it 'renders the requested doctor' do
    get "/api/v1/doctors/#{@doctor.id}"
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['name']).to eq('Solo Boss')
    expect(JSON.parse(response.body)['specialization']).to eq('Oncologist')
  end

  it 'updates a doctor' do
    new_doctor = { doctor: { name: 'Felix Ouma', specialization: 'Optician', picture: 'http://localhost/pic.png' } }
    put "/api/v1/doctors/#{@doctor.id}", params: new_doctor, headers: { Authorization: @token }
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['name']).to eq('Felix Ouma')
    expect(JSON.parse(response.body)['specialization']).to eq('Optician')
  end

  it 'deletes the requested doctor' do
    delete "/api/v1/doctors/#{@doctor.id}", headers: { Authorization: @token }
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body).size).to eq(0)
  end
end
