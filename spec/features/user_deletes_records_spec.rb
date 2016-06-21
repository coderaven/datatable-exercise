require 'rails_helper'

feature 'User deletes' do
	before :each do
	   Sidekiq::Testing.inline!
	   ObjectRecord.import(test_csv_file)
	   visit object_records_index_path    
	end

	scenario ': success', js: true do
      click_button('Delete All Records')
      expect(page).to have_content('All Records successfully deleted')
    end
end