require 'open-uri'
require 'ostruct'

@candidates = []
open('tse_data/consulta_cand_2012_RS.txt', 'r:iso-8859-1') do |file|
  data = file.read
  data.encode!("UTF-8")
  data.each_line do |c_line|
    c_line.gsub!("\"", "") 
    fields = c_line.split ";"
    candidate = OpenStruct.new
    candidate.city = fields[7]
    candidate.role = fields[9]
    candidate.name = fields[10]
    candidate.sequence_code = fields[11]
    candidate.number = fields[12]
    candidate.short_name = fields[13] #nome de urna
    candidate.party_short = fields[17]
    candidate.party = fields[18]
    candidate.alliance_parties = fields[21]
    candidate.alliance_name = fields[22]
    
    if candidate.city == "PORTO ALEGRE"
      @candidates << candidate
      puts candidate
    end
  end
end


puts @candidates.size
