require 'nokogiri'
require 'open-uri'
require 'ostruct'

TSE_URL = "http://www.tse.jus.br"
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

  def candidate_to_s(c)
    c.name + "," + c.short_name + "," + c.number.to_s + "," + c.party + "," + c.alliance + "," + c.photo
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

      # Candidate Details Page
      @profile_details_doc = Nokogiri::HTML(open candidate.profile_link)
      candidate.photo = get_photo_link row

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
      TSE_URL + "/sadEleicaoDivulgaCand2008" + (profile_link.gsub "\.\.", '')
    else
      profile_link
    end
  end

  def get_photo_link(row)
    TSE_URL + @profile_details_doc.xpath("//img")[0]['src']
  end

  def remove_specials(text)
    text.gsub! /[\r\n\t]/, ""
    text.strip!
  end

end
