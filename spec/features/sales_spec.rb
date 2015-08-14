require 'rails_helper'
require 'support/warden'

feature 'add sale' do

  background do
    login_as create(:user), scope: :user
  end

  before do
    product = create(:product)
#   save_and_open_page
  end

  scenario "sale from product page" do
    visit products_path
    click_link 'Soap'
    click_link 'Sell'
  
    fill_in 'Quantity', with: '1'
    fill_in 'Date', with: '01/01/2015'
    click_button 'Sell'

    expect(page).to have_content('Sale has been added')
    
  end  

  scenario "sale from main page" do
    visit root_path
    click_link 'New Sale'
    
    select 'Soap', from: 'sale_product_id'
    fill_in 'Quantity', with: '1'
    fill_in 'Date', with: '01/01/2015'
    click_button 'Sell'

    expect(page).to have_content('Sale has been added')
    
  end  

  scenario "sale without product" do 
    visit root_path
    click_link 'New Sale'
    
    fill_in 'Quantity', with: '1'
    fill_in 'Date', with: '01/01/2015'
    click_button 'Sell'

    expect(page).to have_content("Product can't be blank")
  end


  scenario "Sale without quantity from product page" do 
    visit products_path
    click_link 'Soap'
    click_link 'Sell'
  
    fill_in 'Date', with: '01/01/2015'
    click_button 'Sell'

    expect(page).to have_content("Quantity can't be blank")
  end

  scenario "Sale with bad quantity from product page" do 
    visit products_path
    click_link 'Soap'
    click_link 'Sell'
    
    fill_in 'Quantity', with: 'bla-bla'
    fill_in 'Date', with: '01/01/2015'
    click_button 'Sell'

    expect(page).to have_content("Quantity is not a number")
  end

  scenario "Sale without quantity" do 
    visit root_path
    click_link 'New Sale'
    
    select 'Soap', from: 'sale_product_id'
    fill_in 'Date', with: '01/01/2015'
    click_button 'Sell'

    expect(page).to have_content("Quantity can't be blank")
  end

  scenario "Sale with bad quantity" do 
    visit root_path
    click_link 'New Sale'
    
    fill_in 'Quantity', with: 'bla-bla'
    fill_in 'Date', with: '01/01/2015'
    click_button 'Sell'

    expect(page).to have_content("Quantity is not a number")
  end

  scenario "Sale with quantity less then 1 from product page" do 
    visit products_path
    click_link 'Soap'
    click_link 'Sell'
    
    fill_in 'Quantity', with: -1
    fill_in 'Date', with: '01/01/2015'
    click_button 'Sell'

    expect(page).to have_content("Quantity must be greater than 0")
  end

  scenario "Sale with quantity less then 1" do 
    visit root_path
    click_link 'New Sale'
    
    select 'Soap', from: 'sale_product_id'
    fill_in 'Quantity', with: '-1'
    fill_in 'Date', with: '01/01/2015'
    click_button 'Sell'

    expect(page).to have_content("Quantity must be greater than 0")
  end

  scenario "Sale: quantity with float from product page" do 
    visit products_path
    click_link 'Soap'
    click_link 'Sell'
    
    fill_in 'Quantity', with: 1.3
    fill_in 'Date', with: '01/01/2015'
    click_button 'Sell'

    expect(page).to have_content("Quantity must be an integer")
  end

  scenario "Sale: quantity with float" do 
    visit root_path
    click_link 'New Sale'
    
    select 'Soap', from: 'sale_product_id'
    fill_in 'Quantity', with: '1.3'
    fill_in 'Date', with: '01/01/2015'
    click_button 'Sell'

    expect(page).to have_content("Quantity must be an integer")
  end

  scenario "Sale without date from product page" do 
    visit products_path
    click_link 'Soap'
    click_link 'Sell'
    
    fill_in 'Quantity', with: '1'
    click_button 'Sell'

    expect(page).to have_content("Date can't be blank")
  end

  scenario "Sale without date" do 
    visit root_path
    click_link 'New Sale'
    
    select 'Soap', from: 'sale_product_id'
    fill_in 'Quantity', with: '1'
    click_button 'Sell'

    expect(page).to have_content("Date can't be blank")
  end

end


