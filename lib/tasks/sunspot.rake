desc 'check for a connection with Solr'
task 'solr:check' do
  require 'open-uri'

  config = YAML.load(Erubis::Eruby.new(File.read(File.join('config', 'sunspot.yml'))).result)

  %w(development test).each do |env|
    url = "http://#{config[env]['solr']['hostname']}:#{config[env]['solr']['port']}/solr/admin/ping"

    print "Checking for a Solr instance (#{env}): #{url}..."
    begin
      open(url)
      puts "OK"
    rescue => e
      puts "DOWN"
      puts 'INFO: Looks like Solr is down. Starting it up...'
      begin
        Rake::Task['sunspot:solr:start'].invoke
      rescue
        puts 'There was an issue starting up Solr. Maybe it\'s already running?'
      end
    end
  end
end
