class Event < ActiveRecord::Base
	validates :description, :start_date, :end_date, presence: true
	validate :event_doesnt_clash

	def event_doesnt_clash
		events = Event.all.select { |e| (e.date == date) && (e.id != id) }
		overlapping_events = events.select { |e| (start_time - e.end_time) * (end_time - e.start_time) >= 0 }
		unless overlapping_events.blank?
			errors.add(:description, "This event clashes with another today!")
		end
	end

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
