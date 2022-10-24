class Api::V1::AppointmentsController < ApplicationController
  before_action :authorize_request, only: %i[create update destroy]
  before_action :set_appointment, only: %i[show update destroy]

  # GET /appointments
  def index
    @appointments = Doctor.find(params[:doctor_id]).appointments.all

    render json: @appointments
  end

  # GET /appointments/1
  def show
    render json: @appointment
  end

  # POST /appointments
  def create
    @appointment = @current_user.appointments.new(appointment_params)

    if @appointment.save
      render json: @appointment, status: :created
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /appointments/1
  def update
    if @appointment.update(appointment_params)
      render json: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /appointments/1
  def destroy
    @current_user.appointments.destroy(params[:id])
    render json: @current_user.appointments.all
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.require(:appointment).permit(:date_of_appointment, :time_of_appointment, :doctor_id,
                                        :description)
  end
end
