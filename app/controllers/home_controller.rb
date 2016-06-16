class HomeController < ApplicationController

	before_action :authenticate_user!

	def index
		@start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
	  	@events = current_user.events
  		@events_by_date = @events.group_by(&:date)
	end

	def day_view
		@event = Event.new
		@date = Date.parse(params[:date])
    	@the_date = @date.to_datetime
  		@events = current_user.events
  		@todays_events = @events.where("date = ?", @date)
	end
end
