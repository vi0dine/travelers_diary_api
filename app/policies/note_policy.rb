# frozen_string_literal: true

class NotePolicy < ApplicationPolicy
  def index?
    user and (user.admin? or record.user == user)
  end

  def show?
    user and (user.admin? or record.user == user)
  end

  def create?
    user and (user.admin? or record.user == user)
  end

  def update?
    user and (user.admin? or record.user == user)
  end

  def destroy?
    user and (user.admin? or record.user == user)
  end
end
