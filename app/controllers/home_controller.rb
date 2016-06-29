class HomeController < ApplicationController
	include DayViewHelper
	before_action :authenticate_user!

	def index
		@start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
	  	@events = current_user.events
  		@events_by_date = @events.group_by(&:date)
  		@todays_events = current_user.events.where("date = ?", Date.today)
	end

	def day_view
		@event = Event.new
		@date = Date.parse(params[:date])
    	@the_date = @date.to_datetime
  		@events = current_user.events
  		@options = current_user.option
  		@todays_events = @events.where("date = ?", @date)
  		@events_outside_hours = check_events_against_calender_hours(@todays_events, current_user.option) 
  		
	end
end
