class OptionsController< ApplicationController
	def edit
		@options = Option.find_by(user_id: current_user.id)
	end

	def update
		@option = Option.find_by_id(params[:id])
		if @option.update_attributes(option_params)
			flash[:success] = 'Settings updated!'
			redirect_to root_path
		else
			flash[:danger] = "There was a problem"
			redirect_to :back
		end
	end
end