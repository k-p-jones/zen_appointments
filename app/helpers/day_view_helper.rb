module DayViewHelper
	def day_planner(events)
		Planner.new(self, events).display
	end

	class Planner < Struct.new(:view, :events)
		delegate :content_tag, to: :view

		def hours
			hours = ("00".."23").to_a
		end

		def row_header(hour)
			content_tag :th do 
				hour
			end
		end

		def row_defintion(hour)
			arr = events.select { |e| e.format_start_time == hour}
			if arr.empty? 
				content_tag :td
			else
				content_tag :td, class: "event_placeholder" do 
					arr.map do |e|
						content_tag :div, class: "event_filler", data: { id: "event_#{e.id}", duration: "#{e.duration_in_minutes}", startpos: "#{e.start_time.strftime('%M')}" }, id: "event_#{e.id}" do 
							content_tag :p, e.description
						end
					end.join.html_safe
				end
			end
		end

		def event_filler(event)
			content_tag :p, event.description, class: "event-filler", data: {id: "event"} 
		end

		def display
			content_tag :table, class: "table", id: "day_table" do 
				hours.map do |hour|
					content_tag :tr do 
						row_header(hour) + row_defintion(hour)
					end
				end.join.html_safe
			end
		end
	end
end