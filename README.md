# Dragon Mantis
O projeto consiste em criar uma plataforma Web, em Ruby on Rails, para headhunters e candidatos se relacionarem em torno de vagas de emprego. 

O Dragon Mantis está sendo construído usando Ruby on Rails 6 no padrão MVC e Bootstrap 5.
Ruby version 	3.0.2
Rails version 	6.1.4.1
Database 	SQLite3 
Devise
Capybara 
factory_bot_rails 6.2
rspec-rails 5.0.0 
Como rodar o projeto:

# faça o clone do projeto
git clone https://github.com/francocaldas/dragon_mantis.git
# entre na pasta do projeto
cd blogstrap
# instale as dependências do Ruby on Rails
bundle install
# instale as dependências do Node
yarn install
# crie o banco de dados de deseonvolvimento e de testes
rails db:create
# crie as tabelas 
rails db:migrate
# rode o projeto
rails s

Abra no seu navegador através do link: http://localhost:3000