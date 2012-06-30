require 'rspec'
require './data_importer'

MAYOR_LIST_URL = "mayors.html"

describe DataImporter do
	context "importing mayor data" do
		before do
			@importer = DataImporter.new MAYOR_LIST_URL
			@vera = @importer.candidates.last
		end
		
		it "extracts candidates from document" do 
			@importer.candidates.size.should == 8
		end

		it "maps candidate name" do
			@vera.name.should == "VERA JUSTINA GUASSO"
		end

		it "maps candidate simplified name" do
			@vera.short_name.should == "VERA GUASSO"
		end

		it "maps candidate number" do
			@vera.number.should == 16
		end

		it "maps candidate political party" do
			@vera.party.should == "PSTU"
		end

		it "maps candidate coalition" do
			@vera.coalition.should == "FRENTE DE ESQUERDA"
		end
	end
end