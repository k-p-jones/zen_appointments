module DateFormatHelper
	def format_date(date)
		formatted_date = date.strftime("%a") + " #{date.day.ordinalize}" + " of " + date.strftime("%B %Y")
	end
end