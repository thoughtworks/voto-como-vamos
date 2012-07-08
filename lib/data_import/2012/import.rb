require './src/data_importer'

mayor_list_url = "http://divulgacand2012.tse.jus.br/divulgacand2012/pesquisarCandidato.action?noCandLimpo=&siglaUFSelecionada=RS&codigoMunicipio=88013&codigoCargo=11"

File.open('candidates_2012.txt', 'w') do |file|
  puts "Loading Mayors Candidates..."
  mayor_importer = DataImporter.new mayor_list_url
  mayor_importer.candidates.each do |m|
    file.puts "Prefeito," + mayor_importer.candidate_to_s(m)
  end

  puts "Loading Vereador Candidates..."
  pages = 1..59
  pages.each do |num|
    vereador_list_url = "http://divulgacand2012.tse.jus.br/divulgacand2012/pesquisarCandidato.action?siglaUFSelecionada=RS&codigoMunicipio=88013&d-3573211-p=#{num}&noCandLimpo=&codigoCargo=13" 
  	puts "Loading page #{num} ..."
  	vereador_importer = DataImporter.new vereador_list_url
  	vereador_importer.candidates.each do |v|
      file.puts "Vereador," + vereador_importer.candidate_to_s(v)
    end
  end
end
