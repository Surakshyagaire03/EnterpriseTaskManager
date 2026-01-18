class TaskPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? || user.manager? || record.assignee == user
  end

  def create?
    user.admin? || user.manager?
  end

  def update?
    user.admin? || (user.manager? && record.creator == user)
  end

  def destroy?
    user.admin? || (user.manager? && record.creator == user)
  end

  def mark_complete?
    user.admin? || user.manager? || (user.member? && record.assignee == user)
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.manager?
        # tasks created by manager or assigned to team
        scope.where("creator_id = ? OR assignee_id = ?", user.id, user.id)
      else
        scope.where(assignee: user)
      end
    end
  end
end
