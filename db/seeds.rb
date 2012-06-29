# encoding: utf-8

10.times do |i|
  FactoryGirl.create :candidate, :name => "Candidato #{i}"
end

Category.create(:name => 'Educação')
Category.create(:name => 'Meio-ambiente')
Category.create(:name => 'Segurança')
Category.create(:name => 'Mobilidade Urbana')
Category.create(:name => 'Saúde')
Category.create(:name => 'Cultura e lazer')
Category.create(:name => 'Infra-estrutura')
Category.create(:name => 'Economia')
Category.create(:name => 'Outros')
