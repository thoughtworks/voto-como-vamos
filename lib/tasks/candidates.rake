# encoding: utf-8
require 'open-uri'

namespace :candidates do
  desc 'Import all candidates'
  task :import => :environment do
    open('lib/data_import/candidates_2008.txt') do |file|
      file.each_line do |line|
        v = line.split(",")
        FactoryGirl.create( :candidate_with_proposals, 
          :role => v[0], 
          :name => v[1], 
          :tse_number => v[3], 
          :party => v[4], 
          :alliance => v[5], 
          :photo => v[6]
        )
      end
    end
  end
end
