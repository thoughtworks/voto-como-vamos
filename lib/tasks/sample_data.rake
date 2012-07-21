# encoding: utf-8
namespace :db do
  desc 'Load some sample data in the application'
  task :sample_data => :environment do
    amaralina = FactoryGirl.create(:candidate,
      :name => 'Amaralina Ballerina',
      :short_name => 'Amaralina')

    FactoryGirl.create(:proposal,
      :candidate => amaralina,
      :title => 'Churrasco como Merenda',
      :abstract => 'Picanha, Costela, Vazio',
      :description => 'Descrição Exemplo')

    gabriela = FactoryGirl.create(:candidate,
      :name => 'Gabriela Paz',
      :short_name => 'Gabriela')

    FactoryGirl.create(:proposal,
      :candidate => gabriela,
      :title => 'Fruki nos bebedouros',
      :abstract => 'Guaraná incolor com muito açucar',
      :description => 'Descrição Exemplo')
  end
end
