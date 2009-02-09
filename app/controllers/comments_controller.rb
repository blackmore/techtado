class CommentsController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    params[:comment].merge!('user_id' => current_user.id)
    @comment = @task.comments.create!(params[:comment])
    respond_to do |format|
      format.html { redirect_to @task }
      format.js
    end
  end

end
