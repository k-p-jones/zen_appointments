class EventsController < ApplicationController

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			flash[:success] = "Event created"
		else
			flash[:error] = "Uh Oh, try again!"
		end
		redirect_to root_path
	end

	def edit
		@event = Event.find_by_id(params[:id])
	end

	def update
		@event = Event.find_by_id(params[:id])
		if @event.update_attributes(event_params)
			flash[:success] = 'Event was updated!'
			redirect_to root_path
		else
			flash[:error] = "There was a problem"
			redirect_to root_path
		end
	end

	def destroy
		@event = Event.find_by_id(params[:id])
		if @event.destroy
			flash[:success] = 'Event Was Destroyed'
		else
			flash[:error] = 'Error Destroying Event...'
		end
		redirect_to root_path
	end

	private 

	def event_params
		params.require(:event).permit(:description, :date, :start_time, :end_time)
	end
end
