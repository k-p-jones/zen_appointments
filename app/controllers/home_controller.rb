class HomeController < ApplicationController
	def index
		@event = Event.new
		@start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
	  	@events = Event.all
  		@events_by_date = @events.group_by(&:date)
	end

	def day_view
		@event = Event.new
		@date = Date.parse(params[:date])
    	@the_date = @date.to_datetime
  		@events = Event.all
  		@todays_events = @events.where("date = ?", @date)
	end
end
