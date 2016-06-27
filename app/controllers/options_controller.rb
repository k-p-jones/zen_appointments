class OptionsController< ApplicationController
	def edit
		@option = Option.find_by(user_id: current_user.id)
	end

	def update
		@option = Option.find_by(user_id: current_user.id)
		if @option.update_attributes(option_params)
			flash[:success] = 'Settings updated!'
			redirect_to root_path
		else
			flash[:danger] = "There was a problem"
			session[:option_errors] = @option.errors.full_messages
			redirect_to :back
		end
	end

	private

	def option_params
		params.require(:option).permit(:calender_start_time, :calender_end_time)
	end
end