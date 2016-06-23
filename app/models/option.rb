class Option < ActiveRecord::Base
  belongs_to :user
  after_initialize :init
  validate :end_time_not_less_than_start_time

  private

  def init
  	if self.new_record?
	  	self.calender_start_time ||= "00"
	  	self.calender_end_time ||= "23"
  	end
  end

  def end_time_not_less_than_start_time
	if calender_end_time.to_i < calender_start_time.to_i
		errors.add(:end_time, "cannot be less than the start time")
	end
  end
end
