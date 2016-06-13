class Event < ActiveRecord::Base
	validates :description, :start_time, :end_time, presence: true
	

	def duration
		(self.end_time - self.start_time) / 3600
	end

	def duration_in_minutes
		(self.end_time - self.start_time) / 60
	end

	def format_time
		self.start_time.strftime("%H")
	end
end
