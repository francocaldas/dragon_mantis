# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'

describe 'Visitor visit homepage' do
  it 'and view welcome message' do
    visit root_path

    expect(page).to have_content('Dragon Mantis')
    expect(page).to have_css('div.dropdown')
  end

  it 'and view all active jobs' do
    # Arrange
    headhunter = FactoryBot.create(:headhunter)
    # Act
    Job.create(title: 'Dev sênior Ruby on Rails', description: 'Vaga para desenvolvedor sênior em ruby on rails CLT',
               skills: 'CSS, JS, TDD, kanban', salary_range: 'R$ 8000 a R$ 12000', level: 'Sênior',
               deadline: '20/11/2021', location: 'Remoto', headhunter_id: headhunter.id)
    Job.create(title: 'Dev júnior Ruby on Rails', description: 'Vaga para desenvolvedor júnior em ruby on rails CLT',
               skills: 'CSS, JS, bootstrap', salary_range: 'R$ 3000 a R$ 5000', level: 'Júnior', deadline: '25/11/2021',
               location: 'Fortaleza', headhunter_id: headhunter.id)

    visit root_path

    expect(page).to have_content('Dev sênior Ruby on Rails')
    expect(page).to have_content('Dev júnior Ruby on Rails')
  end

  it 'and register new user candidate' do
    # Arrange
    # Act
    visit root_path
    find(:css, '#signup_candidate').click
    fill_in 'Email', with: 'teste@teste.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    # Assert
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  it 'and register new user headhunter' do
    # Arrange
    # Act
    visit root_path
    find(:css, '#signup_headhunter').click
    fill_in 'Email', with: 'headhunter@teste.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    # Assert
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
