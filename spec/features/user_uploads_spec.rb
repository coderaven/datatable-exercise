require 'rails_helper'

feature 'User uploads file' do
  before :each do
    visit object_records_index_path
  end

  context 'successfully' do
    it 'should display success alert',js: true do
      attach_file("file",test_csv_file.path)
      click_button("Import Records")
      expect(page).to have_content('Records imported successfully.')
    end
  end

  context 'unsuccessfully',js: true do
    it 'should display error alert',js: true do
      attach_file("file",test_csv_file(error: true).path)
      click_button("Import Records")
      expect(page).to have_content('Unable to import: Invalid CSV or File!')
    end
  end
end