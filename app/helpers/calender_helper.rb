module CalenderHelper
	def calender(date, events)
		Calender.new(self, date, events).display	
	end
	
	class Calender < Struct.new(:view, :date, :events)

		include Rails.application.routes.url_helpers
		
		delegate :content_tag, to: :view

		def range
			first = date.beginning_of_month.beginning_of_week
			last = date.end_of_month.end_of_week
			(first..last).to_a
		end

		def weeks
			range.each_slice(7)
		end

		def days
			range.slice(0, 7)
		end

		def header
			content_tag :thead do 
				content_tag :tr, class: "danger" do 
					days.map { |day| content_tag :th, day.strftime("%a") }.join.html_safe
				end
			end	
		end

		def week_rows
			weeks.map { |week| content_tag :tr, weekdays(week) }.join.html_safe
		end

		def weekdays(week)
			 week.map do |day| 
			 	content_tag :td, class: class_check(day) do
			 		content_tag :a, day.strftime("%d"), href: home_day_view_path(date: day)
			 	end
			 end.join.html_safe
		end

		def class_check(day)
			classes = []
			classes << "success" if events[day]
			classes << "active" if day.month != date.month
			classes.empty? ? nil : classes.join(" ")
		end

		def display
			content_tag :table, class: "table table-bordered" do
                header + week_rows
            end
		end
	end
end