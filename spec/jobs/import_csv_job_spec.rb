require 'rails_helper'

RSpec.describe ImportCsvJob, type: :job do
	it 'is expected to enqueue job' do
		record_hash = {object_id: '1', object_type: 'ObjectA', timestamp: '412351252', object_changes: '"{property1: ""value1"", property3: ""value2""}"'}

		ImportCsvJob.perform_later(record_hash)
		expect(ImportCsvJob).to be_processed_in :default
	end
end
