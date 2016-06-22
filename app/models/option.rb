class Option < ActiveRecord::Base
  belongs_to :user
  after_initialize :init

  private

  def init
  	self.calender_start_time ||= "00"
  	self.calender_end_time ||= "23"
  end
end
