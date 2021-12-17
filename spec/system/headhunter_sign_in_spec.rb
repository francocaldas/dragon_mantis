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
    expect(current_path).to eq jobs_path
    expect(page).to have_content('headhunter@teste.com')
    expect(page).to have_link('Sair')
    expect(page).not_to have_css('div.dropdown')
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

  it 'and register new job' do
    # Arrange
    headhunter = FactoryBot.create(:headhunter)
    login_as(headhunter, :scope => :headhunter)
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
    expect(current_path).to eq jobs_path
    expect(page).to have_content('Dev sênior Ruby on Rails')
  end

  it 'and edit a job' do
    # Arrange
    headhunter = FactoryBot.create(:headhunter)
    login_as(headhunter, :scope => :headhunter)
    Job.create(title: 'Dev sênior Ruby on Rails', description: 'Vaga para desenvolvedor sênior em ruby on rails CLT',
               skills: 'CSS, JS, TDD, kanban', salary_range: 'R$ 8000 a R$ 12000', level: 'Sênior',
               deadline: '20/11/2021', location: 'Remoto', headhunter_id: headhunter.id)
    # Act
    visit root_path
    click_on 'Editar'
    fill_in 'Título', with: 'Dev sênior Ruby on Rails Editado'
    click_on 'Salvar'
    # Assert
    expect(current_path).to eq jobs_path
    expect(page).to have_content('Dev sênior Ruby on Rails Editado')
  end

  it 'and visit profile' do
    # Arrange
    headhunter = FactoryBot.create(:headhunter)
    login_as(headhunter, :scope => :headhunter)
    job = Job.create(title: 'Dev sênior Ruby on Rails', description: 'Vaga para desenvolvedor sênior em ruby on rails CLT',
               skills: 'CSS, JS, TDD, kanban', salary_range: 'R$ 8000 a R$ 12000', level: 'Sênior',
               deadline: '20/11/2021', location: 'Remoto', headhunter_id: headhunter.id)
    user = FactoryBot.create(:user)
    Profile.create(name: 'Candidato Um', social_name: 'Candidate', birth_date: '01/01/1999', formation: 'Superior imcompleto', 
                   description: 'Descrição do Candidato Um', experience: 'Experiência do Candidato Um', user_id: user.id)
    Subscription.create(job_id: job.id, user_id: user.id)
    # Act
    visit root_path
    find(:xpath, "//a[@href='/profiles/1']").click
    # Assert
    expect(current_path).to eq profiles_path + '/1'
    expect(page).to have_content('Perfil do candidato')
    expect(page).to have_content('Candidato Um')
  end

  it 'and bookmark profile' do
    # Arrange
    headhunter = FactoryBot.create(:headhunter)
    login_as(headhunter, :scope => :headhunter)
    job = Job.create(title: 'Dev sênior Ruby on Rails', description: 'Vaga para desenvolvedor sênior em ruby on rails CLT',
               skills: 'CSS, JS, TDD, kanban', salary_range: 'R$ 8000 a R$ 12000', level: 'Sênior',
               deadline: '20/11/2021', location: 'Remoto', headhunter_id: headhunter.id)
    user = FactoryBot.create(:user)
    Profile.create(name: 'Candidato Um', social_name: 'Candidate', birth_date: '01/01/1999', formation: 'Superior imcompleto', 
                   description: 'Descrição do Candidato Um', experience: 'Experiência do Candidato Um', user_id: user.id)
    Subscription.create(job_id: job.id, user_id: user.id)
    # Act
    visit profiles_path + '/1'
    click_on 'Favoritar'
    # Assert
    expect(current_path).to eq profiles_path + '/1'
    expect(page).to have_content('Perfil do candidato')
    expect(page).to have_content('Candidato Um')
    expect(page).to have_content('Perfil incluído nos seus favoritos.')
  end

  it 'and write a comment' do
    # Arrange
    headhunter = FactoryBot.create(:headhunter)
    login_as(headhunter, :scope => :headhunter)
    job = Job.create(title: 'Dev sênior Ruby on Rails', description: 'Vaga para desenvolvedor sênior em ruby on rails CLT',
               skills: 'CSS, JS, TDD, kanban', salary_range: 'R$ 8000 a R$ 12000', level: 'Sênior',
               deadline: '20/11/2021', location: 'Remoto', headhunter_id: headhunter.id)
    user = FactoryBot.create(:user)
    Profile.create(name: 'Candidato Um', social_name: 'Candidate', birth_date: '01/01/1999', formation: 'Superior imcompleto', 
                   description: 'Descrição do Candidato Um', experience: 'Experiência do Candidato Um', user_id: user.id)
    Subscription.create(job_id: job.id, user_id: user.id)
    # Act
    visit profiles_path + '/1'
    fill_in 'Comentário', with: 'Comentário de teste com capybara'
    click_on 'Salvar'
    # Assert
    expect(current_path).to eq profiles_path + '/1'
    expect(page).to have_content('Perfil do candidato')
    expect(page).to have_content('Candidato Um')
    expect(page).to have_content('Comentário de teste com capybara')
  end

  it 'and delete a comment' do
    # Arrange
    headhunter = FactoryBot.create(:headhunter)
    login_as(headhunter, :scope => :headhunter)
    job = Job.create(title: 'Dev sênior Ruby on Rails', description: 'Vaga para desenvolvedor sênior em ruby on rails CLT',
               skills: 'CSS, JS, TDD, kanban', salary_range: 'R$ 8000 a R$ 12000', level: 'Sênior',
               deadline: '20/11/2021', location: 'Remoto', headhunter_id: headhunter.id)
    user = FactoryBot.create(:user)
    profile = Profile.create(name: 'Candidato Um', social_name: 'Candidate', birth_date: '01/01/1999', formation: 'Superior imcompleto', 
                   description: 'Descrição do Candidato Um', experience: 'Experiência do Candidato Um', user_id: user.id)
    Subscription.create(job_id: job.id, user_id: user.id)
    Comment.create(profile_id: profile.id, headhunter_id: headhunter.id, body: 'Comentário 1')
    Comment.create(profile_id: profile.id, headhunter_id: headhunter.id, body: 'Comentário 2')
    # Act
    visit profiles_path + '/1'
    find(:xpath, "//a[@href='/comments/2']").click
    # Assert
    expect(current_path).to eq profiles_path + '/1'
    expect(page).to have_content('Perfil do candidato')
    expect(page).to have_content('Candidato Um')
    expect(page).to have_content('Comentário 1')
    expect(page).not_to have_content('Comentário 2')
  end

  it 'and visit my favorites' do
    # Arrange
    headhunter = FactoryBot.create(:headhunter)
    login_as(headhunter, :scope => :headhunter)
    job = Job.create(title: 'Dev sênior Ruby on Rails', description: 'Vaga para desenvolvedor sênior em ruby on rails CLT',
               skills: 'CSS, JS, TDD, kanban', salary_range: 'R$ 8000 a R$ 12000', level: 'Sênior',
               deadline: '20/11/2021', location: 'Remoto', headhunter_id: headhunter.id)
    user = FactoryBot.create(:user)
    profile = Profile.create(name: 'Candidato Um', social_name: 'Candidate', birth_date: '01/01/1999', formation: 'Superior imcompleto', 
                   description: 'Descrição do Candidato Um', experience: 'Experiência do Candidato Um', user_id: user.id)
    Favorite.create(profile_id: profile.id, headhunter_id: headhunter.id)
    # Act
    visit favorites_path
    # Assert
    expect(current_path).to eq favorites_path
    expect(page).to have_content('Meus Favoritos')
    expect(page).to have_content('Candidato Um')
  end
end