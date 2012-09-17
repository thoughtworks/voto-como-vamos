namespace :ownership do
  desc 'Send claim request to all candidates'
  task :send_requests, [:head, :tail] => :environment do |t, args|
    Ownership.send_claim_to_some_candidates(args[:head], args[:tail])
  end
end
