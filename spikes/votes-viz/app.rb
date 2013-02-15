require 'bundler/setup'
Bundler.require

set :static_cache_control, [:public, :max_age => 300]

get '/' do
  slim :index
end

get '/parliamentary/:name' do
  slim :parliamentary
end
