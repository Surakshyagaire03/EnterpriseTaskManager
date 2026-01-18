module Admin
  class UserPolicy < ApplicationPolicy
    def index?
      user.admin?
    end

    def show?
      user.admin?
    end

    def create?
      user.admin?
    end

    def new?
      create?
    end

    def update?
      user.admin?
    end

    def edit?
      update?
    end

    def destroy?
      user.admin?
    end

    class Scope < Scope
      def resolve
        user.admin? ? scope.all : scope.none
      end
    end
  end
end
