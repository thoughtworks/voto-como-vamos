require 'nokogiri'
require 'open-uri'
require 'ostruct'

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
		 	candidate = OpenStruct.new
		 	candidate.name = get_name row
		 	candidate.short_name = get_short_name row
		 	candidate.number = get_number row
		 	candidate.party = get_party row
		 	candidate.alliance = get_alliance row
      candidate.profile_link = get_profile_link row
		 	@candidates << candidate
		end
	end

	def get_name(row)
		remove_specials row.children[0].children[1].child.text
	end

	def get_short_name(row)
		remove_specials row.children[2].children[1].child.text
	end

	def get_number(row)
		(remove_specials row.children[4].child.text).to_i
	end

	def get_party(row)
		remove_specials row.children[8].children[1].children[1].child.text
	end

	def get_alliance(row)
		remove_specials row.children[10].children[1].children[1].child.text
	end

  def get_profile_link(row)
    profile_link = row.children[0].children[1]['href']
    if profile_link.include? "\.\." 
      "http://www.tse.jus.br/sadEleicaoDivulgaCand2008#{profile_link.gsub "\.\.", ''}"
    else
      profile_link
    end
  end

	def remove_specials(text)
		text.gsub! /[\r\n\t]/, ""
		text.strip!
	end
end
