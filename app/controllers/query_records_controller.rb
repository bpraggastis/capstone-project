class QueryRecordsController < ApplicationController

  def create
    @record = QueryRecord.new(query_params)
    @record.start_date = Date.parse("January 1, 1979") if params[:query][:start_date] == ""
    @record.end_date = Date.today if params[:query][:end_date] == ""
    # raise "wtf?"
    # if params[:commit] == "Save Query Record" && session[:user_id]
    #   sd = DateTime.strptime(params[:start_date]) if params[:start_date].length > 0
    #   ed = DateTime.strptime(params[:end_date]) if params[:end_date].length > 0
    #   q = QueryRecord.new(user_id: session[:user_id],
    #                   start_date: sd,
    #                   end_date: ed,
    #                   place_id: params[:place_id].to_i,
    #                   disease_id: params[:disease_id].to_i,
    #                   outbreak_id: params[:outbreak_id].to_i)
    #   if q.save
    #     flash[:notice] = "Your query record was successfully saved."
    #   else
    #     flash[:notice] = "There was an error and your query was not saved."
    #   end
    #   params[:commit] = ""
    # end
    @record.user_id = session[:user_id]

    @record.save
    session[:query_id] = @record.id
    render "home/index"
  end

  def update
    if params[:id].to_i == session[:query_id]
      @query = QueryRecord.find(session[:query_id])
      @query.update(query_params)
      @query.save
      render json: {status: "200"}
    end
  end

  def destroy
    @record = QueryRecord.find(params[:id])
    @user = User.find(session[:user_id])
    if @record.user_id == @user.id
      @record.delete
      flash[:notice] = "Query record successfully deleted."
      session[:query_id] = nil
      render json: {status: "record deleted"}
    else
      flash[:notice] = "You are not authorized to delete that query."
      redirect_to root_path
    end
  end

  private

  def query_params
    params.require(:query).permit(:outbreak_id, :disease_id, :start_date, :end_date,
                                  :place_id)
  end

end
