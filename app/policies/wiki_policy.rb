class WikiPolicy < ApplicationPolicy
  
  attr_reader :user, :wiki
  
    def self.can_access(user, wiki) # for everything other than delete and create
      if ! user.present? # must be logged in to do anything
        return false
      end
    
      if user.admin? # an admin can do anything
        return true
      end
      
      if wiki.user == user # the owner of a wiki can access it
        return true
      end

      if wiki.private
        return wiki.collaborating_users.include?(user) # only collaborators can access private wiki
      end
      
      return true # everyone can access non-private wiki
    end

  
  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end
  
  def update? # update requires access
    WikiPolicy.can_access(user,wiki)
  end
  
  def edit? # edit requires access
    WikiPolicy.can_access(user,wiki)
  end
  
  def new? # anyone can create non-private wiki (default for new)
    WikiPolicy.can_access(user,wiki)
  end
  
  def show? # viewing requires access
    WikiPolicy.can_access(user,wiki)
  end
  
  def destroy? # only an admin can destroy a wiki
    user.present? && user.admin? # only an admin can destroy a wiki
  end
  
  def create? # to create a wiki, you must be able to access it
    if ! WikiPolicy.can_access(user,wiki)
      return false
    end

    # only admins and premium users can create private wikis
    (! wiki.private) || user.admin? || user.premium?
  end
  
  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end
    
    def resolve # only return those wikis the user can access
        scope.select{ |wiki| WikiPolicy.can_access(user,wiki) }
    end
  end
  
end