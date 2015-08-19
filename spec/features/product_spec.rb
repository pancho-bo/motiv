require 'rails_helper'
require 'support/warden'

feature "Product basic interaction" do
  background do
    login_as create(:user), scope: :user
  end

  scenario "Add product" do
    visit products_path
    click_link 'New Product'
    fill_in 'Name', with: 'Bread'
    click_button 'Save'
    expect(page).to have_content 'Product was successfully created'
  end

  scenario "Current price" do

    price = create(:price)
    visit products_path
    click_link 'Soap'

    expect(page).to have_content 'Current price is 120'
  end

  scenario "Current price is not defined" do

    price = create(:old_price)
    visit products_path
    click_link 'Soap'

    expect(page).to have_content 'Current price is not defined'
  end
end
