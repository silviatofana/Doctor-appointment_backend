require 'rails_helper'

RSpec.describe 'Users', type: %w[request feature] do
  before do
    post '/api/v1/users',
         params: { name: 'Solo Boss', password: '123456', password_confirmation: '123456', email: 'soloboss@gmail.com', role: 'admin' }
    @user = User.all.last
  end

  it 'renders the users list' do
    get '/api/v1/users/'
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body).size).to eq(1)
  end

  it 'renders the requested user' do
    get "/api/v1/users/#{@user.id}"
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['name']).to eq('Solo Boss')
    expect(JSON.parse(response.body)['email']).to eq('soloboss@gmail.com')
  end

  it 'deletes the requested user' do
    delete "/api/v1/users/#{@user.id}"
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body).size).to eq(0)
  end

  it 'updates a user' do
    new_user = { name: 'Felix Ouma', password: '123456', password_confirmation: '123456', email: 'felixouma@gmail.com' }
    put "/api/v1/users/#{@user.id}", params: new_user
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['name']).to eq('Felix Ouma')
    expect(JSON.parse(response.body)['email']).to eq('felixouma@gmail.com')
  end
end
