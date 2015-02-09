class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id.to_s
      redirect_to @user
    else
      redirect_to root_path
    end
  end

  def show
    #Only logged-in users can view their own pages
    unless params[:id] == session[:user_id]
      flash[:notice] = "You are not authorized to see that page."
      redirect_to root_path
    end
    @user = User.find(session[:user_id])
    @comments = Comment.where(user_id: @user.id)
    @queries = QueryRecord.where(user_id: @user.id)
    # Bring up comments and queries, too?
  end

  def update
    #This allows users to update their own info, and admins to update tier status
    unless authorization_check
      flash[:notice] = "You are not authorized to update that user's profile."
      redirect_to root_path
    end
    @user = User.find(params[:id])
  end

  def delete
    #This allows users to delete themselves, or admins to delete them.
    unless authorization_check
      flash[:notice] = "You are not authorized to delete that user."
      redirect_to root_path
    end
    @user = User.find(params[:user_id])
    @user.delete
    #Do we want to delete their comments and queries as well?
    #Do we want to email them these things first?
    flash[:notice] = "User successfully deleted."
    redirect_to root_path
  end

  private

  def authorization_check
    params[:id] == session[:user_id] || User.find(session[:user_id]).tier == "admin"
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
