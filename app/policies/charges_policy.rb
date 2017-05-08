  class WikiPolicy < ApplicationPolicy

  attr_reader :user, :wiki
  
  def update?
    user.present?
  end
  
  def create?
    user.present?
  end
end