# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||=User.new

    if user.admin?
    can :manage, :all
    end

    if user.worker?
      can :read, Task
      can :create, Application, worker_id: user.id
      can :read, Application, worker_id: user.id
      can :create, Profile, worker_id: user.id
      can :read, Profile, worker_id: user.id
      can :update, Profile, worker_id: user.id
      can :add_resume, Profile, worker_id: user.id
    end
    if user.contractor?
      can :create, Task
      can :update, Task, contractor_id: user.id
      can :destroy, Task, contractor_id: user.id
      can :post_task, Task, contractor_id: user.id
      can :read, Task
      can :work_start, Task
      can :read, Application, task: { contractor_id: user.id }
      can :approve, Application
      can :reject, Application
      can :read, Application
      can :create, Profile, contractor_id: user.id
      can :read, Profile, contractor_id: user.id
      can :update, Profile, contractor_id: user.id
      # can :create, Payments
    end
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
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
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
