require "google_drive"
require 'open-uri'

class GdriveFileHandler
	attr_reader :uploaded_file_name, :drive_folder_title, :session, :gdrive_file

	def initialize(config_file, file_path, drive_folder_title)
		@file_path = file_path

		if Rails.env.production?
			@session = GoogleDrive.saved_session(config_file)
			@uploaded_file_name = "#{Time.now.to_i}.csv"
			@drive_folder_title = drive_folder_title
			@gdrive_file = nil
		end
	end

	def upload!
		if Rails.env.production?
			@gdrive_file = @session.upload_from_file(@file_path, @uploaded_file_name, convert: false)
			folder = @session.collection_by_title(@drive_folder_title)
			folder.add(@gdrive_file)
		end
	end

	def uploaded_file_link
		if Rails.env.production?
			@gdrive_file.api_file.web_content_link if @gdrive_file
		else
			@file_path
		end
	end
end