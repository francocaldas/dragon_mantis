require 'rails_helper'
require_relative '../support/devise'

describe 'visit your profile' do
  it 'candidate register your profile' do
    # Arrange
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user) 
    # Act
    visit root_path
    click_on 'Perfil'
    fill_in 'Nome Completo', with: 'Candidato de Teste'
    fill_in 'Nome Social', with: 'Candidate'
    fill_in 'Data de Nascimento', with: '01/01/1994' 
    fill_in 'Formação', with: 'Superior incompleto'
    fill_in 'Descrição', with: 'Descrição do candidato'
    fill_in 'Experiência', with: 'Experiência profissional do candidato'
    click_on 'Salvar'
    # Assert
    expect(current_path).to eq root_path
  end
end