class WikiPolicy < ApplicationPolicy
  
  attr_reader :user, :wiki
  
  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.present? && (user.admin? || user.premium?)
        scope.all
      else
        scope.where(private: false)
      end
    end
  end
  
  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end
  
  def update? # user must be logged in to update a wiki
    user.present?
  end
  
  def edit? # user must be logged in to edit a wiki
    user.present?
  end
  
  def new? # user must be logged in to create a wiki
    user.present?
  end
  
  def destroy?
    user.present? && user.admin? # only an admin can destroy a wiki
  end
  
  def create?
    if ! user.present?  # user must be logged in to create a wiki
      return false
    end
    # only admins and premium users can create private wikis
    (! wiki.private) || user.admin? || user.premium?
  end
end