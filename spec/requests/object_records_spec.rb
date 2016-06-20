require 'rails_helper'
require 'spec_helper'

RSpec.describe 'ObjectRecords' do

  describe 'GET /object_records#index' do
    it 'display object records table', js: true do
        visit object_records_index_path
        expect(page).to have_content('Search')
    end
  end
  
end