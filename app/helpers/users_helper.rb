module UsersHelper
  def hidden_video_filter(user)
    if !user.filtered_customers.empty?
      user.filtered_customers
    end
  end
end
