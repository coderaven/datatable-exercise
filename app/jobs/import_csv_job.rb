require 'open-uri'

class ImportCsvJob < ActiveJob::Base
  queue_as :default

  def perform(csv_path)
  	csv_file = open(csv_path,'rb:UTF-8')

	options = {row_sep: :auto, col_sep: ",", user_provided_headers: [:object_id], headers_in_file: false}

	headers_exist = false
	SmarterCSV.process(csv_file, options) { |header| headers_exist = true if header.first[:object_id].to_s.strip == "object_id"; break }

	options = {
		row_sep: :auto, col_sep: ",", 
		user_provided_headers: [:object_id, :object_type, :timestamp, :object_changes], 
		remove_empty_values: true, 
		headers_in_file: headers_exist
  	}

  	SmarterCSV.process(csv_file, options) do |array|
	    ProcessCsvJob.perform_later(array.first)
	end
  end
end
