class Event < ActiveRecord::Base
	validates :description, :start_time, :end_time, presence: true
	validate :start_time_less_than_end_time
	validate :event_doesnt_clash
	validate :event_less_or_equal_to_15_minutes
	validate :event_is_within_calender_hours

	belongs_to :user

	def event_doesnt_clash
		events = Event.all.select { |e| (e.id != id) && (e.date == date) && (e.user_id == user_id) }
		overlaps = events.select { |e| (start_time.strftime("%H%M").to_i - e.end_time.strftime("%H%M").to_i) * (end_time.strftime("%H%M").to_i - e.start_time.strftime("%H%M").to_i) < 0 }
		unless overlaps.blank?
			errors.add(:appointment, "clashes with other appointments today!")
		end
	end

	def event_less_or_equal_to_15_minutes
		if (end_time.strftime("%H%M").to_i) - (start_time.strftime("%H%M").to_i) < 15
			errors.add(:appointment, "cannot be less than 15 minutes" )
		end
	end

	def start_time_less_than_end_time
		if start_time > end_time
			errors.add(:start_time, "cannot be after end time")
		end
	end

	def event_is_within_calender_hours
		options = self.user.option
		if start_time.strftime("%H") < options.calender_start_time
			errors.add(:appointment, "cannot start before your calenders start time")
		end
		if end_time.strftime("%H") > options.calender_end_time
			errors.add(:appointment, "cannot end after your calenders end time")
		end
	end

	def duration
		(self.end_time - self.start_time) / 3600
	end

	def duration_in_minutes
		(self.end_time - self.start_time) / 60
	end

	def format_start_time
		self.start_time.strftime("%H")
	end
end
