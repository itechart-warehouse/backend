# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(current_user)
    role = current_user.user_role_id
    case role
    when 1 # System Admin ability
      can :manage, :all
    when 2 # Company owner ability
      can :read, :user
    when 3 # Company admin ability
      can :read, :user
    when 4 # Warehouse admin ability
      can :read, :user
    when 5 # Dispatcher ability
      can :read, :user
    when 6 # Inspector ability
      can :read, :user
    when 7 # Warehouse Manager ability
      can :read, :user
    end
  end
end
