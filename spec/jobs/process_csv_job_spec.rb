require 'rails_helper'

RSpec.describe ProcessCsvJob, type: :job do
	it 'is expected to enqueue job' do
		ProcessCsvJob.perform_later(test_csv_file.path)
		expect(ProcessCsvJob).to be_processed_in :default
	end
end
