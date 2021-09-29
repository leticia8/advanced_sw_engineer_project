require 'rails_helper'

RSpec.feature 'login', type: :feature do
  let!(:user) { create(:user, password: 'specspec') }

  context 'with valid credentials' do
    it 'redirects logged in user to root' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'specspec'
      click_button 'Ingresar'

      expect(page).to have_current_path(root_path)
    end
  end

  context 'with invalid credentials' do
    it 'remains in the login page' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'spec'
      click_button 'Ingresar'

      expect(page).to have_content('Email y/o contraseña inválidos.')
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end