require 'rspec'
require './data_importer'

#MAYOR_LIST_URL = "http://www.tse.jus.br/sadEleicaoDivulgaCand2008/gerenciarregistrocandidatura/manterCandidato!listarCandidatosPorMunicipio.action?codigoUESelec=88013&codigoCargoEletivoSelec=11&codigoSituacaoRegistro=12"
MAYOR_LIST_URL = "mayors.html"

describe DataImporter do
	context "importing mayor data" do
		before do
			@importer = DataImporter.new MAYOR_LIST_URL
		end
		
		it "extracts candidates from document" do 
			@importer.candidates.size.should == 8
		end

		context "mapping candidate data" do
			before do
				@carlos = @importer.candidates.first
			end
			
			it "maps candidate name" do
				@carlos.name.should == "CARLOS ANTONIO GOMES"
			end

			it "maps candidate simplified name" do
				@carlos.short_name.should == "CARLOS GOMES"
			end
		end
	end
end