require 'rails_helper.rb'

feature "Looking up recipes", js: true do
  before do
    create(:recipe, name: 'Baked Potato w/ Cheese')
    create(:recipe, name: 'Garlic Mashed Potatoes')
    create(:recipe, name: 'Potatoes Au Gratin')
    create(:recipe, name: 'Baked Brussel Sprouts')
  end
  scenario "finding recipes" do
    visit '/'
    fill_in "keywords", with: "baked"
    click_on "Search"

    expect(page).to have_content("Baked Potato")
    expect(page).to have_content("Baked Brussel Sprouts")
  end
end