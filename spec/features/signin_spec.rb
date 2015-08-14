require 'rails_helper'

feature "Signing in" do
  background do
    create(:user)
  end

  scenario "Signing in with correct credentials" do
    visit root_path
    within '.navbar' do
      fill_in 'Email', with: 'admin@ex.com'
      fill_in 'Password', with: '12345678'
      click_button 'Sign In'
    end
    expect(page).to have_content 'Signed in successfully'
  end
end
