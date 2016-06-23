require "google_drive"

class GdriveHandler
	def initialize(config_file)
		@session = GoogleDrive.saved_session(config_file)
	end

	def upload_to_folder(file_path, drive_folder_title)
		drive_file_title = "#{Time.now.to_i}.csv"
		file = session.upload_from_file(file_path, drive_file_title, convert: false)
		folder = session.collection_by_title(drive_folder_title)
		folder.add(file)
	end

	def file_from_folder(drive_file_title, drive_folder_title)
		@session.collection_by_title(drive_folder_title).file_by_title(drive_file_title)
	end
end