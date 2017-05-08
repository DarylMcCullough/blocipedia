  class WikiPolicy < ApplicationPolicy

  attr_reader :user
  
  def create?
    user.present?
  end
end