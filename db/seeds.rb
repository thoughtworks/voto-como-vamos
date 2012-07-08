# encoding: utf-8
['Educação', 'Meio-ambiente', 'Segurança', 'Mobilidade Urbana', 'Saúde', 'Cultura e Lazer', 'Infra-estrutura', 'Economia', 'Outros'].each do |category|
  Category.create!(:name => category)
end
