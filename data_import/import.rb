require './data_importer'

mayor_list_url = "http://www.tse.jus.br/sadEleicaoDivulgaCand2008/gerenciarregistrocandidatura/manterCandidato!listarCandidatosPorMunicipio.action?codigoUESelec=88013&codigoCargoEletivoSelec=11&codigoSituacaoRegistro=12"
puts "Loading Mayors Candidates..."
mayor_importer = DataImporter.new mayor_list_url
puts mayor_importer.candidates

pages = 1..59
puts "Loading Vereador Candidates..."
pages.each do |num|
	vereador_list_url = "http://www.tse.jus.br/sadEleicaoDivulgaCand2008/gerenciarregistrocandidatura/manterCandidato!listarCandidatosPorMunicipio.action?codigoCargoEletivoSelec=13&page=#{num}&codigoUESelec=88013&codigoSituacaoRegistro=12"
	puts "Loading page #{num} ..."
	vereador_importer = DataImporter.new vereador_list_url
	puts vereador_importer.candidates
end