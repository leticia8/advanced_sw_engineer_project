require 'rails_helper'

RSpec.feature 'create_election', type: :feature do
  let!(:user) { create(:user, password: 'specspec') }
  let!(:election) { build(:election) }
  let!(:proposal) { build(:proposal) }
  let!(:option) { build(:option) }

  context 'create election with proposal and options successfully' do
    it 'redirects the user to the elections and the created election is shown' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'specspec'
      click_button 'Ingresar'
      visit new_election_path
      fill_in 'election_description', with: election.description
      fill_in 'election_start_date', with: election.start_date
      fill_in 'election_finish_date', with: election.finish_date
      select "Ciudad", from: 'election_segmented_by'
      select election.condition, from: 'election_condition'
      click_button 'Guardar'
      expect(page).to have_content('Datos de la Elección')
      fill_in 'proposal_name', with: proposal.name
      fill_in 'proposal_description', with: proposal.description
      click_button 'Crear Propuesta'
      expect(page).to have_content(proposal.name)
      expect(page).to have_content(proposal.description)
      find(:xpath, "//a[contains(text(), 'Agregar Opciones')]").click
      fill_in 'option_description', with: option.description
      click_button 'Crear Opción'
      expect(page).to have_content('Opción: '+ option.description)
      visit elections_path
      expect(page).to have_content(election.description)
      expect(page).to have_content(election.condition)
      find(:xpath, "//a[contains(text(), 'Activar')]").click
      expect(page).to have_content('La elección fue activada!')
      visit elections_path
      expect(page).to have_content('Activada')
    end
  end


end