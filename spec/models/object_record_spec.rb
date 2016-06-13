require 'rails_helper'

describe ObjectRecord do
  it { is_expected.to validate_presence_of(:object_id) }
  it { is_expected.to validate_presence_of(:object_type) }
  it { is_expected.to validate_presence_of(:timestamp) }
  it { is_expected.to validate_presence_of(:object_changes) }

  describe 'importing csv to database' do
  	context 'when csv is invalid' do
  		it 'should return false' do
  			expect(ObjectRecord.import(test_csv_file(error: true))).to be false
  		end
  	end

  	context 'when csv is valid' do
  		it 'should success be able to insert data to database' do
  			expect(ObjectRecord.import(test_csv_file)).to be true
  		end
  	end
  end
end

