class Task < ApplicationRecord
  # ✅ Correct enum syntax
  enum :status, { pending: 0, in_progress: 1, completed: 2 }

  # Associations
  belongs_to :creator, class_name: "User"
  belongs_to :assignee, class_name: "User"

  # Validations
  validates :title, presence: true
  validate :due_date_cannot_be_in_the_past

  def due_date_cannot_be_in_the_past
    return if due_date.blank?
    errors.add(:due_date, "can't be in the past") if due_date < Date.today
  end
end
