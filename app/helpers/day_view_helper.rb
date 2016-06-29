module DayViewHelper
	def day_planner(events, options)
		Planner.new(self, events, options).display
	end

	class Planner < Struct.new(:view, :events, :options)

		include Rails.application.routes.url_helpers

		delegate :content_tag, to: :view

		def hours
			hours = (options.calender_start_time..options.calender_end_time).to_a
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
						#will not display an event if it ends outside the calender finish time, existing code prevents the need for fallbacks for
						#events starting before calender start time
						unless e.end_time.strftime("%H") > options.calender_end_time
							content_tag :div, class: "event_filler", data: { id: "event_#{e.id}", duration: "#{e.duration_in_minutes}", startpos: "#{e.start_time.strftime('%M')}", colour: "#{e.colour}" }, id: "event_#{e.id}" do 
								content_tag(:a, "X", href: event_path(e.id), class: "event_delete_tag",  data: { method: :delete, confirm: 'are you sure?' }) +
								content_tag(:p, e.start_time.strftime("%H:%M") + " - " + e.end_time.strftime("%H:%M")) +
								content_tag(:a, e.description, href: event_path(e))	
							end
						end
					end.join.html_safe
				end
			end
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

	def check_events_against_calender_hours(events, user_settings)
		todays_events = events
		start_time = user_settings.calender_start_time
		end_time = user_settings.calender_end_time
		events_outside_calender_hours = []

		for event in todays_events do
			if (event.start_time.strftime("%H") < start_time) || (event.end_time.strftime("%H") > end_time)
				events_outside_calender_hours << event
			end
		end
		return events_outside_calender_hours	
	end
end