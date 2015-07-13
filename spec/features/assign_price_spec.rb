require 'rails_helper'
require 'support/warden'

feature 'assign prices' do

  background do
    login_as create(:user), scope: :user
  end

 # let(:product){FactoryGirl.create(:product)}

  before do
    product = create(:product)
#    visit root_path
    visit products_path
    save_and_open_page

#    print product.name
    
    click_link product.name
    click_link 'Assign price'
  end

  scenario "assign prices" do 
    fill_in 'Price', with: '120'
    fill_in 'Start Date', with: '01/01/2015'
    fill_in 'End Date', with: '01/12/2015'
    click_button 'Assign'

    expect(page).to have_content('Price assigned')
  end

  scenario "intersection prices" do 
    fill_in 'Price', with: '120'
    fill_in 'Start Date', with: '01/01/2015'
    fill_in 'End Date', with: '01/12/2015'
    click_button 'Assign'
    click_link 'Assign price'
    fill_in 'Price', with: '120'
    fill_in 'Start Date', with: '01/06/2015'
    fill_in 'End Date', with: '01/12/2015'
    click_button 'Assign'

    expect(page).to have_content('Intersection of price')
  end

  scenario "assign price without price" do 
    click_button 'Assign'

    expect(page).to have_content("Price can't be blank")
  end

  scenario "assign price without start date" do 
    fill_in 'Price', with: '120'
    click_button 'Assign'

    expect(page).to have_content("Start date can't be blank")
  end

  scenario "assign price without end date" do 
    fill_in 'Price', with: '120'
    fill_in 'Start Date', with: '01/01/2015'
    click_button 'Assign'

    expect(page).to have_content("End date can't be blank")
  end

end


