class ImportCsvJob < ActiveJob::Base
  queue_as :default

  def perform(csv_record)
  	csv_record[:object_changes] = ApplicationController.helpers.generate_hash(csv_record[:object_changes])
    ObjectRecord.create(csv_record)
  end
end
