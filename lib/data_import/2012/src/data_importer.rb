require 'nokogiri'
require 'open-uri'
require 'ostruct'

CITY_CODE = "88013" #FIXME: hardcode it for now to Porto Alegre (88013)

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
    c.name + "," + c.short_name + "," + c.number.to_s + "," + c.party + "," + c.alliance + "," + c.photo + ","+ c.site
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
      candidate.sequence_number = get_sequence_number row

      # Candidate Details Page
      @profile_details_doc = Nokogiri::HTML(open candidate.profile_link)
      candidate.photo = get_photo_link(row)
      candidate.site = get_site_link

      @candidates << candidate
    end
  end

  def get_name(row)
    remove_specials row.children[2].child.text
  end

  def get_short_name(row)
    short_name = row.children[4].child.text
    short_name.gsub(",", "") # found some names with commas, so...removing them
  end

  def get_number(row)
    (row.children[6].child.text).to_i
  end

  def get_party(row)
    row.children[10].child.text
  end

  def get_alliance(row)
    row.children[12].child.text
  end

  def get_sequence_number(row)
    row.child.children[1][:value]
  end

  def get_profile_link(row)
    sequence_code = get_sequence_number row

    return "http://divulgacand2012.tse.jus.br/divulgacand2012/mostrarFichaCandidato.action?sqCand=#{sequence_code}&codigoMunicipio=#{CITY_CODE}"
    #"adenilso.html"
  end

  def get_photo_link(row)
   "http://divulgacand2012.tse.jus.br/divulgacand2012/mostrarFotoCandidato.action?sqCand=#{get_sequence_number(row)}&codigoMunicipio=#{CITY_CODE}"
  end

  def get_site_link
    a_site = @profile_details_doc.xpath("//a[@style='color: #375F8A;']")
    return (a_site ? a_site.text.strip.gsub(",", "") : nil)
  end

  def remove_specials(text)
    text.gsub! /[\r\n\t]/, ""
    text.gsub! ",", ""
    text.strip!
  end
end
