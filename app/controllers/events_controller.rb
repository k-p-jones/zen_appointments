class EventsController < ApplicationController

	before_action :authenticate_user!

	def new
		@event = Event.new
	end

	def show
		@event = Event.find_by_id(params[:id])
		session[:errors] = nil #wipe errors so old session errors dont appear in the edit form
	end

	def create
		@event = Event.new(event_params)
		@event.user_id = current_user.id
		if @event.save
			flash[:success] = "Event created"
			session[:errors] = nil
		else
			flash[:danger] = "Uh Oh, try again!"
			session[:errors] = @event.errors.full_messages
			session[:description] = @event.description
			session[:notes] = @event.notes
			session[:location] = @event.location
			session[:colour] = @event.colour
			session[:start_time] = @event.start_time.strftime("%H:%M")
			session[:end_time] = @event.end_time.strftime("%H:%M")
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
			redirect_to home_day_view_path(@event, :date => @event.date)
		else
			flash[:danger] = "There was a problem"
			session[:errors] = @event.errors.full_messages
			redirect_to :back
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
		params.require(:event).permit(:description, :date, :start_time, :end_time, :colour, :notes, :location)
	end
end
