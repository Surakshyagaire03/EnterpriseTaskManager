class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Correct enum syntax — **do NOT use a colon before enum**
  enum :role, { member: 0, manager: 1, admin: 2 }
  enum :status, { invited: 0, active: 1, inactive: 2 }

  # Associations
  has_many :created_tasks, class_name: "Task", foreign_key: "creator_id", dependent: :destroy
  has_many :assigned_tasks, class_name: "Task", foreign_key: "assignee_id", dependent: :destroy
end
