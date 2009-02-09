module CommentsHelper
  def comment_details(comment)
    user = User.find(comment.user_id)
    "Posted by #{user.first_name} #{user.last_name} #{time_ago_in_words(comment.created_at)} ago"
  end
  
end
