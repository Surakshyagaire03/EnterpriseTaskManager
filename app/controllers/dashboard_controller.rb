class DashboardController < ApplicationController
  def index
    @tasks = policy_scope(Task)
  end
end
