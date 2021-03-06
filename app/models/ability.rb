class Ability
  include CanCan::Ability

  def initialize(user)
    # no guest allow after admin created
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :manage, User, :id => user.id 
      can :manage, Contact, :user_id => user.id
      can :read, Contact
      can :create, Contact
      can :update, Contact, :id => user.contact_ids 
      can :read, Family
      can :create, Family
      #can :update, Family, :id => user.contact.family_id
      can :read, Post 
      can :create, Post 
      can :update, Post, :id => user.post_ids 
      can :read, Book
      can :create, Book
      can :update, Book, :id => user.book_ids
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
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
