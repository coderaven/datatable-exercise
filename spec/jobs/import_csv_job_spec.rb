require 'rails_helper'

RSpec.describe ImportCsvJob, type: :job do
	it 'is expected to enqueue job' do
		ImportCsvJob.perform_later(test_csv_file.path)
		expect(ImportCsvJob).to be_processed_in :default
	end
end
