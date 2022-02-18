# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(current_user)
    role = current_user.user_role_id
    if    role==1 # System Admin ability
      can :manage, :all
    elsif role==2 # Company owner ability
      can :read, :user
    elsif role==3 # Company admin ability
      can :read, :user
    elsif role==4 # Warehouse admin ability
      can :read, :user
    elsif role==5 # Dispatcher ability
      can :read, :user
    elsif role==6 # Inspector ability
      can :read, :user
    elsif role==7 # Warehouse Manager ability
      can :read, :user
    end
  end
end
