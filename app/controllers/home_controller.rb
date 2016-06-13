class HomeController < ApplicationController
	def index
		@start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
	  	@events = Event.all
	  	@event = Event.new
  		@events_by_date = @events.group_by(&:date)
	end

	def day_view
		@date = Date.parse(params[:date])
    	@the_date = @date.to_datetime
  		@events = Event.all
  		@todays_events = @events.where("date = ?", @date)
	end
end
