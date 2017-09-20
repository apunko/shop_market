module ApplicationHelper
  def format_date_time(date_time)
    date_time.strftime("%d.%m.%Y - %H:%M:%S")
  end
end
