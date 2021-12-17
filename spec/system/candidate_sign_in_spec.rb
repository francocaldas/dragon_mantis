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
    click_on 'Entrar'
    # Assert
    expect(current_path).to eq new_profile_path
    expect(page).to have_content('candidato@teste.com')
    expect(page).to have_link('Sair')
    expect(page).not_to have_css('div.dropdown')
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

  it 'and see a job vacancy' do
    # Arrange
    headhunter = FactoryBot.create(:headhunter)
    Job.create(title: 'Dev sênior Ruby on Rails', description: 'Vaga para desenvolvedor sênior em ruby on rails CLT',
          skills: 'CSS, JS, TDD, kanban', salary_range: 'R$ 8000 a R$ 12000', level: 'Sênior',
          deadline: '20/11/2021', location: 'Remoto', headhunter_id: headhunter.id)
    Job.create(title: 'Dev júnior Ruby on Rails', description: 'Vaga para desenvolvedor júnior em ruby on rails CLT',
          skills: 'CSS, JS, bootstrap', salary_range: 'R$ 3000 a R$ 5000', level: 'Júnior', deadline: '25/11/2021',
          location: 'Fortaleza', headhunter_id: headhunter.id)
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    # Act
    visit root_path
    find(:xpath, "//a[@href='/jobs/1']").click
    # Assert
    expect(current_path).to eq jobs_path + '/1'
    expect(page).to have_content('Dev sênior Ruby on Rails')
  end

  it 'and apply for a job' do
    # Arrange
    headhunter = FactoryBot.create(:headhunter)
    Job.create(title: 'Dev sênior Ruby on Rails', description: 'Vaga para desenvolvedor sênior em ruby on rails CLT',
          skills: 'CSS, JS, TDD, kanban', salary_range: 'R$ 8000 a R$ 12000', level: 'Sênior',
          deadline: '20/11/2021', location: 'Remoto', headhunter_id: headhunter.id)
    Job.create(title: 'Dev júnior Ruby on Rails', description: 'Vaga para desenvolvedor júnior em ruby on rails CLT',
          skills: 'CSS, JS, bootstrap', salary_range: 'R$ 3000 a R$ 5000', level: 'Júnior', deadline: '25/11/2021',
          location: 'Fortaleza', headhunter_id: headhunter.id)
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    # Act
    visit jobs_path + '/1'
    click_on 'Increver-se'
    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content('Inscrição realizada com sucesso')
  end

  it 'and view all comments' do
    # Arrange
    headhunter = FactoryBot.create(:headhunter)
    job = Job.create(title: 'Dev sênior Ruby on Rails', description: 'Vaga para desenvolvedor sênior em ruby on rails CLT',
          skills: 'CSS, JS, TDD, kanban', salary_range: 'R$ 8000 a R$ 12000', level: 'Sênior',
          deadline: '20/11/2021', location: 'Remoto', headhunter_id: headhunter.id)
    user = FactoryBot.create(:user)
     
    profile = Profile.create(name: 'Candidato Um', social_name: 'Candidate', birth_date: '01/01/1999', formation: 'Superior imcompleto', 
      description: 'Descrição do Candidato Um', experience: 'Experiência do Candidato Um', user_id: user.id)
    Comment.create(profile_id: profile.id, headhunter_id: headhunter.id, body: 'Comentário 1')
    Comment.create(profile_id: profile.id, headhunter_id: headhunter.id, body: 'Comentário 2')

    login_as(user, :scope => :user)
    # Act
    visit root_path
    click_on 'Comentários'
    # Assert
    expect(current_path).to eq comments_path
    expect(page).to have_content('Comentário 1')
    expect(page).to have_content('Comentário 2')
  end
end