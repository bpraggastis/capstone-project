class QueryRecord < ActiveRecord::Base
  belongs_to :user

#  Jan+24%2C+1979

  def parsed_date date
    the_date = which_date date
    m = the_date.strftime("%b")
    d = the_date.strftime("%d")
    y = the_date.strftime("%Y")
    m + "+" + d + "%2C+" + y
  end

  private

  def which_date date
    if date == "end"
      self.end_date
    elsif date == "start"
      self.start_date
    end
  end

end
