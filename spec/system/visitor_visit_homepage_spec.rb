# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'

describe 'Visitor visit homepage' do
  it 'and view welcome message' do
    visit root_path

    expect(page).to have_content('Dragon Mantis')
  end

  it 'and view all active jobs' do
    # Arrange
    @headhunter = FactoryBot.create(:headhunter)
    # Act
    Job.create(title: 'Dev sênior Ruby on Rails', description: 'Vaga para desenvolvedor sênior em ruby on rails CLT',
               skills: 'CSS, JS, TDD, kanban', salary_range: 'R$ 8000 a R$ 12000', level: 'Sênior',
               deadline: '20/11/2021', location: 'Remoto', headhunter_id: @headhunter.id)
    Job.create(title: 'Dev júnior Ruby on Rails', description: 'Vaga para desenvolvedor júnior em ruby on rails CLT',
               skills: 'CSS, JS, bootstrap', salary_range: 'R$ 3000 a R$ 5000', level: 'Júnior', deadline: '25/11/2021',
               location: 'Fortaleza', headhunter_id: @headhunter.id)

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

  it 'and headhunter logs into the application' do
    # Arrange
    @headhunter = FactoryBot.create(:headhunter)
    # Act
    visit root_path
    #login_headhunter
    within('div.dropdown') do
      click_on 'Headhunter'
    end
    fill_in 'Email', with: 'headhunter@teste.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    # Assert
    expect(page).to have_content('Sair')
    expect(page).to have_content('headhunter@teste.com')
  end

  it 'and candidate logs into the application' do
    # Arrange
    @user = FactoryBot.create(:user)
    # Act
    visit root_path
    within('div.dropdown') do
      click_on 'Candidato'
    end
    fill_in 'Email', with: 'candidato@teste.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    # Assert
    expect(page).to have_content('Sair')
  end

  it 'and headhunter logs out of the application' do
    # Arrange
    @headhunter = FactoryBot.create(:headhunter)
    # Act
    visit root_path
    within('div.dropdown') do
      click_on 'Headhunter'
    end
    fill_in 'Email', with: 'headhunter@teste.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    visit root_path
    click_on 'Sair'   
    # Assert
    expect(page).to have_content('Cadastre-se')
  end

  it 'and headhunter register new job' do
    # Arrange
    @headhunter = FactoryBot.create(:headhunter)
    visit root_path
    within('div.dropdown') do
      click_on 'Headhunter'
    end
    fill_in 'Email', with: 'headhunter@teste.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    # Act
    visit root_path
    click_on 'Cadastrar Vaga'
    fill_in 'Título', with: 'Dev sênior Ruby on Rails'
    fill_in 'Descrição', with: 'Vaga para desenvolvedor sênior em ruby on rails CLT'
    fill_in 'Habilidades Desejadas', with: 'CSS, JS, TDD, kanban' 
    fill_in 'Faixa Salarial', with: 'R$ 8000 a R$ 12000' 
    fill_in 'Nível', with: 'Sênior'
    fill_in 'Data Limite', with: '20/11/2021' 
    fill_in 'Localização', with: 'Remoto'
    click_on 'Salvar'
    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content('Dev sênior Ruby on Rails')
  end
end
