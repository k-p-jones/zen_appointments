class EventsController < ApplicationController

	before_action :authenticate_user!

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		@event.user_id = current_user.id
		if @event.save
			flash[:success] = "Event created"
		else
			flash[:danger] = "Uh Oh, try again!"
			session[:errors] = @event.errors.full_messages
		end
		redirect_to :back
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
			flash[:danger] = "There was a problem"
			redirect_to root_path
		end
	end

	def destroy
		@event = Event.find_by_id(params[:id])
		if @event.destroy
			flash[:success] = 'Event Was Destroyed'
		else
			flash[:danger] = 'Error Destroying Event...'
		end
		redirect_to :back
	end

	private 

	def event_params
		params.require(:event).permit(:description, :date, :start_time, :end_time, :colour)
	end
end
