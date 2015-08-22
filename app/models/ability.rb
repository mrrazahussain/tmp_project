class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else
      can :read, :all

      # If user is an author
      can :update, Course do |course|
        course.authors.include? user
      end

      can :view, Course do |course|
        course.authors.include? user or course.users.include? user
      end

      cannot :read, Topic do |topic|
        !topic.referred_course.authors.include? user and !topic.referred_course.users.include? user
      end

      can :update, Topic do |topic|
        topic.referred_course.authors.include? user
      end

      can :update_outcome, Topic do |topic|
        topic.referred_course.users.include? user
      end
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
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
