require 'rails_helper'

feature 'User inspects' do
  before :each do
    ObjectRecord.import(test_csv_file)
    visit object_records_index_path    
  end

  context 'with a missing field' do
    scenario ': missing object_id field', js: true do
      input_an_inspect(object_id: " ",object_type: "ObjectA", timestamp: "412351252")

      expect(page).to have_selector("#objects-record", :text => "No Data Available")
    end

    scenario ': missing object_type field', js: true do
      input_an_inspect(object_id: "1",object_type: " ", timestamp: "412351252")

      expect(page).to have_selector("#objects-record", :text => "No Data Available")
    end

    scenario ': missing timestamp field', js: true do
      input_an_inspect(object_id: "1",object_type: "ObjectA", timestamp: " ")

      expect(page).to have_selector("#objects-record", :text => "No Data Available")
    end
  end

  context 'with filled all fields', js: true do
    scenario ': no result' do
      input_an_inspect(object_id: "1",object_type: "ObjectA", timestamp: "112351252")
      expect(page).to have_selector("#objects-record", :text => "No Data Available")
    end

    scenario ': with result', js: true do
      input_an_inspect(object_id: "1",object_type: "ObjectA", timestamp: "412351252")

      expect(page).to have_selector("#objects-record td", :text => "1")
      expect(page).to have_selector("#objects-record td", :text => "ObjectA")
      expect(page).to have_selector("#objects-record td", :text => "1983-01-25 14:00:52 +00:00 (412351252)")
      expect(page).to have_selector("#objects-record td", :text => 'property1: ""value1"", property3: ""value2""')
    end

    scenario ': proper merged associated properties', js: true do
      input_an_inspect(object_id: "1",object_type: "ObjectA", timestamp: "467765765")

      expect(page).to have_selector("#objects-record td", :text => "1")
      expect(page).to have_selector("#objects-record td", :text => "ObjectA")
      expect(page).to have_selector("#objects-record td", :text => "1984-10-27 22:56:05 +00:00 (467765765)")
      expect(page).to have_selector("#objects-record td", :text => 'property1: ""altered value1"", property3: ""value2"", property2: ""random value2""')
    end
  end
end