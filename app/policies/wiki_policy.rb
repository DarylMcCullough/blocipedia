class WikiPolicy < ApplicationPolicy
  
  attr_reader :user, :wiki
  
    def self.can_access(user, wiki)
      if ! user.present?
        return false
      end
    
      if user.admin?
        return true
      end
      
      if wiki.user == user
        return true
      end

      if wiki.private
        return wiki.collaborating_users.include?(user)
      end
      return true
    end

  
  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end
  
  def update? # user must be logged in to update a wiki
    WikiPolicy.can_access(user,wiki)
  end
  
  def edit? # user must be logged in to edit a wiki
    WikiPolicy.can_access(user,wiki)
  end
  
  def new? # user must be logged in to create a wiki
    WikiPolicy.can_access(user,wiki)
  end
  
  def show?
    WikiPolicy.can_access(user,wiki)
  end
  
  def destroy?
    user.present? && user.admin? # only an admin can destroy a wiki
  end
  
  def create?
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
    
    def resolve
        scope.select{ |wiki| WikiPolicy.can_access(user,wiki) }
    end
  end
  
end