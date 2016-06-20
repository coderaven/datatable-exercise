require 'rails_helper'

feature 'User searches on table' do
  before :each do
    ObjectRecord.import(test_csv_file)
    visit object_records_index_path
  end

  scenario 'with an object id', js: true do
    input_a_search "1"

    expect(page).to have_css(".sorting_1", text: "1")
    # save_and_open_screenshot
  end

  scenario 'with an object type', js: true do
    input_a_search "ObjectA"

    expect(page).to have_selector("td", text: "ObjectA")
  end

  scenario 'with a timestamp', js: true do
    input_a_search "412351252"

    expect(page).to have_selector("td", text: "412351252")
  end

  scenario 'with a date time', js: true do
    input_a_search "1983-01-25 14:00:52 +00:00"

    expect(page).to have_selector("td", text: "1983-01-25 14:00:52 +00:00")
  end
end
