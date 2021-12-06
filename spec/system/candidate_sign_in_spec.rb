require 'rails_helper'
require_relative '../support/devise'

describe 'Candidate sign in' do
  it 'should sign in' do
    # Arrange
    user = FactoryBot.create(:user)
    # Act
    visit root_path
    within('div.dropdown') do
      click_on 'Candidato'
    end
    fill_in 'Email', with: 'candidato@teste.com'
    fill_in 'Password', with: '123456'
    click_on 'Entar'
    # Assert
    expect(current_path).to eq new_profile_path
    expect(page).to have_content('candidato@teste.com')
    expect(page).to have_link('Sair')
    expect(page).not_to have_content('Login')
  end

  it 'should sign out' do
    # Arrange
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    # Act
    visit root_path
    click_on 'Sair'   
    # Assert
    expect(current_path).to eq root_path
    expect(page).not_to have_content('candidato@teste.com')
    expect(page).not_to have_link('Sair')
    expect(page).to have_content('Login')
  end
end