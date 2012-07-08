require 'rspec'
require '../src/data_importer'

MAYOR_LIST_URL = "candidate_list_2012.html"

describe DataImporter do
	context "importing mayor data" do
		before do
			@importer = DataImporter.new MAYOR_LIST_URL
			@adenilso = @importer.candidates.last
		end
		
		it "extracts candidates from document" do 
			@importer.candidates.size.should == 10
		end

		it "maps candidate name" do
			@adenilso.name.should == "ADILSO LUIS PIMENTEL CORLASSOLI"
		end

		it "maps candidate simplified name" do
			@adenilso.short_name.should == "PROFESSOR ADILSO"
		end

		it "maps candidate political party" do
			@adenilso.party.should == "PT"
		end

		it "maps candidate alliance" do
			@adenilso.alliance.should == "COLIGACAO PT - PPL - PTC"
		end

		it "maps candidate number" do
			@adenilso.number.should == 13333
		end

    it "maps candidate profile details page "do 
      @adenilso.profile_link.should == "adenilso.html"
    end

    it "maps candidate sequence number" do
      @adenilso.sequence_number.should == "210000000360"
    end
    
    it "maps candidate site" do 
      @adenilso.site.should == "http://www.professoradilso.blogspot.com"
    end

    it "maps candidate photo link" do
      @adenilso.photo.should == "http://divulgacand2012.tse.jus.br/divulgacand2012/mostrarFotoCandidato.action?sqCand=210000000360&codigoMunicipio=88013"
    end
	end
end
