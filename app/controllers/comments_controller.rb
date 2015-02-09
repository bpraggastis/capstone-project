class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to QueryRecord.find(@comment.query_record_id)
    elsif params[:comment][:query_record_id]
      flash[:notice] = "Comment failed to save."
      redirect_to QueryRecord.find(params[:comment][:query_record_id])
    end
  end

  def delete
    @comment = Comment.find(params[:id])
    if authorization_check
      @comment.delete
      redirect_to User.find(session[:user_id])
    else
      flash[:notice] = "You are not authorized to delete that comment."
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :content, :query_record_id)
  end

  def authorization_check
    @comment.user_id == session[:user_id] || User.find(session[:user_id]).tier == "admin"
  end


end
