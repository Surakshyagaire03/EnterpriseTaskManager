class TaskMailer < ApplicationMailer
  default from: "no-reply@enterprise-task-manager.com"

  # Email for assigned task
  def assigned_email(task)
    @task = task
    @assignee = task.assignee
    @creator = task.creator

    mail(to: @assignee.email, subject: "New Task Assigned: #{@task.title}")
  end
end
