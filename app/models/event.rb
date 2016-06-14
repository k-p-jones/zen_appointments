class Event < ActiveRecord::Base
	validates :description, :start_time, :end_time, presence: true
	validate :start_time_less_than_end_time
	validate :event_doesnt_clash

	def event_doesnt_clash
		events = Event.all.select { |e| (e.id != id) && (e.date = date) }
		overlaps = events.select { |e| (start_time.strftime("%H%M").to_i - e.end_time.strftime("%H%M").to_i) * (end_time.strftime("%H%M").to_i - e.start_time.strftime("%H%M").to_i) < 0 }
		unless overlaps.blank?
			errors.add(:event, "clashes with other events today")
		end
	end

	def start_time_less_than_end_time
		if start_time > end_time
			errors.add(:start_time, "cannot be after end time")
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
