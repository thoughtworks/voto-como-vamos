namespace :ownership do
  desc 'Send revindication request to all candidates'
  task :send_requests => :environment do
    Ownership.send_revindication_to_all_candidates
  end
end
