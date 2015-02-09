class QueryRecordController < ApplicationController

  def create
    @record = QueryRecord.new(query_params)
    if @record.save
      redirect_to @query
    else
      flash[:notice] = "Query record failed to save."
      redirect_to root_path
    end
  end

  def show
    @record = QueryRecord.find(params[:id])
  end

  def destroy
    @record = QueryRecord.find(params[:id])
    @user = User.find(session[:user_id])
    if @record.user_id == @user.id
      @record.delete
      flash[:notice] = "Query record successfully deleted."
      redirect_to @user
    else
      flash[:notice] = "You are not authorized to delete that query."
      redirect_to @user
    end
  end

  private

  def query_params
    params.require(:query).permit(:disease, :disease, :start_date,
                                  :end_date, :location, :user_id)
  end

end
