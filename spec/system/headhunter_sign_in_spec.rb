require 'rails_helper'
require_relative '../support/devise'

describe 'Headhunter sign in' do
  it 'should sign in' do
    # Arrange
    headhunter = FactoryBot.create(:headhunter)
    # Act
    visit root_path
    within('div.dropdown') do
      click_on 'Headhunter'
    end
    fill_in 'Email', with: 'headhunter@teste.com'
    fill_in 'Password', with: '123456'
    click_on 'Entrar'
    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content('headhunter@teste.com')
    expect(page).to have_link('Sair')
    expect(page).not_to have_content('Login')
  end

  it 'should sign out' do
    # Arrange
    headhunter = FactoryBot.create(:headhunter)
    login_as(headhunter, :scope => :headhunter)
    # Act
    visit root_path
    click_on 'Sair'   
    # Assert
    expect(current_path).to eq root_path
    expect(page).not_to have_content('headhunter@teste.com')
    expect(page).not_to have_link('Sair')
    expect(page).to have_content('Login')
  end
end