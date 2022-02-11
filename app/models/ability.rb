# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(current_user)
    role = current_user.role_id
    if  role==1 # System Admin ability
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
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
