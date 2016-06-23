require 'rails_helper'

RSpec.describe ProcessCsvJob, type: :job do
	it 'is expected to enqueue job' do
		record_hash = {object_id: '1', object_type: 'ObjectA', timestamp: '412351252', object_changes: '"{property1: ""value1"", property3: ""value2""}"'}

		ProcessCsvJob.perform_later(record_hash)
		expect(ProcessCsvJob).to be_processed_in :default
	end
end
