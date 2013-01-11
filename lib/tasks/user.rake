namespace :user do
  desc 'Send email about pesquisa to all users'
  task :send_pesquisa => :environment do
    User.send_pesquisa_to_users
  end
end
