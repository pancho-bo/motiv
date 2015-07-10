feature 'assign prices' do

  background do
    create(:user)
  end

  let(:product){FactoryGirl.create(:product)}

  before do
# Authentication
    visit root_path
    fill_in 'Email', with: 'admin@ex.com'
    fill_in 'Password', with: '12345678000'
    click_button 'Log in'

#    click_link 'Products'
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

