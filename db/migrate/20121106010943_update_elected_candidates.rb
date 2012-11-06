class UpdateElectedCandidates < ActiveRecord::Migration
  ELECTED_CANDIDATES = [
                        "12", # Fortunatti
                        "50000", # Pedro Ruas
                        "65100", # Joao Derly
                        "11111", # Guilherme Socias Villela
                        "12345", # Marcio Bins Ely
                        "12122", # Dr Thiago Duarte
                        "11011", # Kevin Krieger
                        "12180", # Mauro Zacher
                        "12700", # Claudio Janta
                        "14714", # Cassio Trogildo
                        "12123", # Joao Bosco Vaz
                        "15200", # Valter Nagelstein
                        "14014", # Dr. Goulart
                        "10300", # Waldir Canal
                        "12112", # Luciano Marcantonio
                        "11633", # Joao Carlos Nedel
                        "15500", # Idenir Cecchim
                        "55555", # Bernardinho Vendruscolo
                        "50500", # Fernanda Melchionna
                        "13113", # Sofia Cavedon
                        "14777", # Elizandro Sabino
                        "10700", # Jose Freitas
                        "12035", # Delegado Cleiton
                        "13007", # Mauro Pinheiro
                        "23200", # Any Ortiz
                        "13123", # Marcelo Sgarbossa
                        "65165", # Jussara Cony
                        "14122", # Paulo Brum
                        "13013", # Engenheiro Comassetto
                        "13021", # Alberto Kopittke
                        "55007", # Tarciso Flecha Negra
                        "15000", # Professor Garcia
                        "15800", # Lourdes Sprenger
                        "25625", # Pujol
                        "40540", # Airto Ferronato
                        "45321", # Mario Manfro
                        "40012", # Paulinho Motorista
                        ]

  def up
    Candidate.where(:tse_number => ELECTED_CANDIDATES).each do |candidate|
      candidate.update_attributes!(:elected => true)
    end
  end

  def down
    Candidate.all.each do |candidate|
      candidate.update_attributes!(:elected => false)
    end
  end
end
