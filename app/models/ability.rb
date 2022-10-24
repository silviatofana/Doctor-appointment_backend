class Ability
  include CanCan::Ability

  def initialize(user)
    can :destroy, Appointment do |appointment|
      appointment.user == user
    end

    can :update, Appointment do |appointment|
      appointment.user == user
    end

    can :create, Appointment
    can :create, Doctor
  end
end
