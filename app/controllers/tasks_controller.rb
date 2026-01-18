class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update destroy mark_complete]

  def index
    @tasks = policy_scope(Task)
  end

  def new
    @task = Task.new
    authorize @task
  end

  def create
    @task = Task.new(task_params)
    @task.creator = current_user
    authorize @task

    if @task.save
      TaskMailer.with(task: @task).assigned_email.deliver_later
      redirect_to tasks_path, notice: "Task created successfully and email sent to assignee"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @task
  end

  def update
    authorize @task
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @task
    @task.destroy
    redirect_to tasks_path, notice: "Task deleted"
  end

  # New action to mark a task complete
  def mark_complete
    authorize @task, :mark_complete?
    @task.update(status: :completed)
    TaskMailer.with(task: @task).completed_email.deliver_later
    redirect_to tasks_path, notice: "Task marked complete"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :status, :assignee_id)
  end
end
