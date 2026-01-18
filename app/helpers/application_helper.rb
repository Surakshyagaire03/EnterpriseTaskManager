module ApplicationHelper
  def display_name(user)
  user.first_name.presence || user.email
end

end
