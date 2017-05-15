class WikiPolicy < ApplicationPolicy
  
  attr_reader :user, :wiki
  
  def update?
    user.present?
  end
  
  def create? # user must be logged in to create a wiki
    if ! user.present?
      return false
    end
    if wiki.private
      return user.admin? || user.premium?
    end
  end
end