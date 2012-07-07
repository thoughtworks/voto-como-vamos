require './src/data_importer'

mayor_list_url = "http://www.tse.jus.br/sadEleicaoDivulgaCand2008/gerenciarregistrocandidatura/manterCandidato!listarCandidatosPorMunicipio.action?codigoUESelec=88013&codigoCargoEletivoSelec=11&codigoSituacaoRegistro=12"


File.open('a_candidates_2008.txt', 'w') do |file|
  puts "Loading Mayors Candidates..."
  mayor_importer = DataImporter.new mayor_list_url
  mayor_importer.candidates.each do |m|
    file.puts "Prefeito," + mayor_importer.candidate_to_s(m)
  end

  puts "Loading Vereador Candidates..."
  pages = 1..59
  pages.each do |num|
    vereador_list_url = "http://www.tse.jus.br/sadEleicaoDivulgaCand2008/gerenciarregistrocandidatura/manterCandidato!listarCandidatosPorMunicipio.action?codigoCargoEletivoSelec=13&page=#{num}&codigoUESelec=88013&codigoSituacaoRegistro=12"
  	puts "Loading page #{num} ..."
  	vereador_importer = DataImporter.new vereador_list_url
  	vereador_importer.candidates.each do |v|
      file.puts "Vereador," + vereador_importer.candidate_to_s(v)
    end
  end
end
