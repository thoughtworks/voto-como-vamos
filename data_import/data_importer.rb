require 'nokogiri'
require 'open-uri'
require './candidate'

class DataImporter
	def initialize(url)
		@candidates = []
		@url = url
		@doc = Nokogiri::HTML(open url)
		load_candidates
	end

	def candidates
		@candidates
	end

	private
	def load_candidates
		 @doc.xpath("//tr[@class='odd'] | //tr[@class='even']").each do |row|
		 	candidate = Candidate.new
		 	candidate.name = get_name(row)
		 	candidate.short_name = get_short_name(row)
		 	@candidates << candidate
		end
	end

	def get_name(row)
		remove_specials row.children[0].children[1].child.text
	end

	def get_short_name(row)
		remove_specials row.children[2].children[1].child.text
	end

	def remove_specials(text)
		text.gsub! /[\r\n\t]/, ""
		text.strip!
	end
end