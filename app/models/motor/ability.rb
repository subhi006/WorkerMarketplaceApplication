
module Motor
  class Ability
    include CanCan::Ability

    def initialize(user)
      user ||= User.new

      if user.admin?
        can :manage, :all
        can :access, :rails_admin
      else
        can :access, :rails_admin
      end
    end
  end
end
