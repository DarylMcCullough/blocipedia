class WikiPolicy < ApplicationPolicy
  
  attr_reader :user, :wiki
  
  def update?
    user.present?
  end
  
  def create? # user must be logged in to create a wiki
    user.present?
  end
end