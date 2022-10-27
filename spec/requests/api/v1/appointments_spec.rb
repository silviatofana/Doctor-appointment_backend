require 'swagger_helper'

RSpec.describe 'api/v1/appointments', type: :request do
  path '/api/v1/doctors/{doctor_id}/appointments' do
    # You'll want to customize the parameter types...
    parameter name: 'doctor_id', in: :path, type: :string, description: 'doctor_id'

    get('list appointments') do
      response(200, 'successful') do
        let(:doctor_id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create appointment') do
      parameter({
                  in: :header,
                  type: :string,
                  name: :Authorization,
                  required: true,
                  description: 'Client token'
                })
      response(200, 'successful') do
        security [Authorization: {}]
        let(:Authorization) { "Authorization #{generate_token}" }
        let(:doctor_id) { '123' }

        parameter name: :appointment, in: :body, schema: {
          type: :object,
          properties: {
            date_of_appointment: { type: :string },
            time_of_appointment: { type: :string },
            description: { type: :string },
            user_id: { type: :string },
            doctor_id: { type: :string }
          },
          required: %w[date_of_appointment time_of_appointment description user_id doctor_id]
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/doctors/{doctor_id}/appointments/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'doctor_id', in: :path, type: :string, description: 'doctor_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show appointment') do
      response(200, 'successful') do
        let(:doctor_id) { '123' }
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    patch('update appointment') do
      parameter({
                  in: :header,
                  type: :string,
                  name: :Authorization,
                  required: true,
                  description: 'Client token'
                })
      response(200, 'successful') do
        security [Authorization: {}]
        let(:Authorization) { "Authorization #{generate_token}" }
        let(:doctor_id) { '123' }
        let(:id) { '123' }
        parameter name: :appointment, in: :body, schema: {
          type: :object,
          properties: {
            date_of_appointment: { type: :string },
            time_of_appointment: { type: :string },
            description: { type: :string },
            user_id: { type: :string },
            doctor_id: { type: :string }
          },
          required: %w[date_of_appointment time_of_appointment description user_id doctor_id]
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update appointment') do
      parameter({
                  in: :header,
                  type: :string,
                  name: :Authorization,
                  required: true,
                  description: 'Client token'
                })
      response(200, 'successful') do
        security [Authorization: {}]
        let(:Authorization) { "Authorization #{generate_token}" }
        let(:doctor_id) { '123' }
        let(:id) { '123' }

        parameter name: :appointment, in: :body, schema: {
          type: :object,
          properties: {
            date_of_appointment: { type: :string },
            time_of_appointment: { type: :string },
            description: { type: :string },
            user_id: { type: :string },
            doctor_id: { type: :string }
          },
          required: %w[date_of_appointment time_of_appointment description user_id doctor_id]
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete appointment') do
      parameter({
                  in: :header,
                  type: :string,
                  name: :Authorization,
                  required: true,
                  description: 'Client token'
                })

      response(200, 'successful') do
        security [Authorization: {}]
        let(:Authorization) { "Authorization #{generate_token}" }
        let(:doctor_id) { '123' }
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
