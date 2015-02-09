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

  private

  def comment_params
    params.require(:comment).permit(:user_id, :content, :query_record_id)
  end


end
