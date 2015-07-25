require 'rails_helper'
require 'support/warden'

feature 'add sale' do

  background do
    login_as create(:user), scope: :user
  end

  before do
    product = create(:product)
  end

  scenario ""sale from product page" do
    visit products_path
    click_link product.name
    click_link 'Sale'
    
    fill_in 'Quantity', with: '1'
    fill_in 'Date of sale', with: '01/01/2015'
    click_button 'Sale'

    expect(page).to have_content('Sale has been added')
    
  end  

  scenario ""sale from main page" do
    visit root_path
    click_link 'Sale'
    
    choose('Soar')
    fill_in 'Quantity', with: '1'
    fill_in 'Date of sale', with: '01/01/2015'
    click_button 'Sale'

    expect(page).to have_content('Sale has been added')
    
  end  

  scenario "sale without product" do 
    visit root_path
    click_link 'Sale'

    fill_in 'Quantity', with: '1'
    fill_in 'Date of sale', with: '01/01/2015'
    click_button 'Sale'

    expect(page).to have_content("Product can't be blank")
  end

  scenario "Sale without quantity" do 
    visit root_path
    click_link 'Sale'
    
    choose('Soar')
    fill_in 'Date of sale', with: '01/01/2015'
    click_button 'Sale'

    expect(page).to have_content("Quantity cant't be blank")
  end

  scenario "Sale with bad quantity" do 
    visit root_path
    click_link 'Sale'
    
    choose('Soar')
    fill_in 'Date of sale', with: '01/01/2015'
    click_button 'Sale'

    expect(page).to have_content("Quantity is not a number")
  end

  scenario "Sale with bad quantity" do 
    visit root_path
    click_link 'Sale'
    
    choose('Soar')
    fill_in 'Quantity', with: 'bla-bla'
    fill_in 'Date of sale', with: '01/01/2015'
    click_button 'Sale'

    expect(page).to have_content("Quantity is not a number")
  end

  scenario "Sale with quantity less then 1" do 
    visit root_path
    click_link 'Sale'
    
    choose('Soar')
    fill_in 'Quantity', with: -1
    fill_in 'Date of sale', with: '01/01/2015'
    click_button 'Sale'

    expect(page).to have_content("Quantity should be more than 0")
  end

  scenario "Sale: quantity with float" do 
    visit root_path
    click_link 'Sale'
    
    choose('Soar')
    fill_in 'Quantity', with: 1.5
    fill_in 'Date of sale', with: '01/01/2015'
    click_button 'Sale'

    expect(page).to have_content("Quantity should be integer")
  end

  scenario "Sale without date" do 
    visit root_path
    click_link 'Sale'
    
    choose('Soar')
    fill_in 'Quantity', with: 1
    click_button 'Sale'

    expect(page).to have_content("Date can't be blank")
  end


end

