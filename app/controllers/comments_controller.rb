class CommentsController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    if params[:freeze]
      @task.update_attributes(:status  => -2)
      params[:comment][:body] = '<strong class="freeze">Frozen</strong>' + params[:comment][:body]

    elsif params[:unfreeze]
      @task.update_attributes(:status  => 1)
      params[:comment][:body] = '<strong class="unfreeze">Unfrozen</strong>' + params[:comment][:body]
    end
    params[:comment].merge!('user_id' => current_user.id)
    @comment = @task.comments.create!(params[:comment])
    respond_to do |format|
      format.html { redirect_to @task }
      format.js
    end
  end
end
