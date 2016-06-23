require 'sidekiq/api'

module ApplicationHelper
	def queued_job_count
		Sidekiq::ProcessSet.new.first['busy']
	end

	def generate_hash(string)
		arr_sep = ','
		key_sep = ':'
		array = string.split(arr_sep)
		hash = {}

		array.each do |e|
			key_value = e.split(key_sep)
			hash[key_value[0].strip.gsub(/^{/,"")] = key_value[1].strip.gsub(/}$/,"")
		end

		hash
	end

	def pretty_format_changes(changes)
	    pretty = ""
	    changes.each do |key,value|
			pretty << "#{key}: \"#{value}\", "
	    end
	    pretty.strip.gsub(/,$/,"")
  	end

  	def pretty_date_format(timestamp)
  		"#{timestamp.strftime('%Y-%m-%d %H:%M:%S %Z')} (#{timestamp.to_i})"
  	end

	def timestamp_formatter(time_string)
		Time.at(Integer(time_string)).to_i
	rescue StandardError
		Chronic.parse(time_string.strip).to_i
  	end
end
