module ApplicationHelper
  def standard_date(date)
    date.strftime("%B %d, %Y") if date
  end
end
