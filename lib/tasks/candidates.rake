# encoding: utf-8
require 'open-uri'

namespace :candidates do
  desc 'Import all candidates'
  task :import => :environment do
    open('lib/data_import/candidates_2012.txt') do |file|
      file.each_line do |line|
        c = Candidate.new
        c.role, c.name, short_name, c.tse_number, c.party, c.alliance, c.photo, c.site = line.split(",")
        c.email = "candidate@email.com" # TSE does not provide email, how to import it? 
        begin 
          c.save!
        rescue # lots of invalid emails provided by candidates, bypassing it
          c.site = nil
          c.save!
        end
      end
    end
  end
end
