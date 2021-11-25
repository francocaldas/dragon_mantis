# frozen_string_literal: true

require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'and view welcome message' do
    visit root_path

    expect(page).to have_content('Dragon Mantis')
  end

  it 'and view all active jobs' do
    Job.create(title: 'Dev sênior Ruby on Rails', description: 'Vaga para desenvolvedor sênior em ruby on rails CLT',
               skills: 'CSS, JS, TDD, kanban', salary_range: 'R$ 8000 a R$ 12000', level: 'Sênior',
               deadline: '20/11/2021', location: 'Remoto')
    Job.create(title: 'Dev júnior Ruby on Rails', description: 'Vaga para desenvolvedor júnior em ruby on rails CLT',
               skills: 'CSS, JS, bootstrap', salary_range: 'R$ 3000 a R$ 5000', level: 'Júnior', deadline: '25/11/2021',
               location: 'Fortaleza')

    visit root_path

    expect(page).to have_content('Dev sênior Ruby on Rails')
    expect(page).to have_content('Dev júnior Ruby on Rails')
  end

  it 'and register new user candidate' do
    # Arrange
    # Act
    visit root_path
    click_on 'Candidato'
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
    click_on 'Headhunter'
    fill_in 'Email', with: 'teste@teste.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    # Assert
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  it 'and the user logs in' do
    # Arrange

    # Act
    #visit root_path
    #click_on 'Login'
    #fill_in 'Email', with: 'teste@teste.com'
    #fill_in 'Password', with: '123456'
    #click_on 'Login'
    # Assert
    #expect(page).to have_content('Singed in successfully.')
  end
end
