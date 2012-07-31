# encoding: utf-8
module PartiesHelper
  PARTY_NAMES = {
    "PMDB" => "Partido do Movimento Democrático Brasileiro",
    "PTB" => "Partido Trabalhista Brasileiro",
    "PDT" => "Partido Democrático Trabalhista",
    "PT" => "Partido dos Trabalhadores",
    "DEM" => "Democratas",
    "PC do B" => "Partido Comunista do Brasil",
    "PSB" => "Partido Socialista Brasileiro",
    "PSDB" => "Partido da Social Democracia Brasileira",
    "PTC" => "Partido Trabalhista Cristão",
    "PSC" => "Partido Social Cristão",
    "PMN" => "Partido da Mobilização Nacional",
    "PRP" => "Partido Republicano Progressista",
    "PPS" => "Partido Popular Socialista",
    "PV" => "Partido Verde",
    "PT do B" => "Partido Trabalhista do Brasil",
    "PRTB" => "Partido Renovador Trabalhista Brasileiro",
    "PP" => "Partido Progressista",
    "PSOL" => "Partido Socialismo e Liberdade",
    "PSTU" => "Partido Socialista dos Trabalhadores Unificado",
    "PCB" => "Partido Comunista Brasileiro",
    "PSDC" => "Partido Social Democrata Cristão",
    "PCO" => "Partido da Causa Operária",
    "PHS" => "Partido Humanista da Solidariedade",
    "PPL" => "Partido Pátria Livre",
    "PR" => "Partido da República",
    "PSD" => "Partido Social Democrático",
    "PRB" => "Partido Republicano Brasileiro",
    "PSL" => "Partido Social Liberal"
  }

  def party_full_name(party)
    PARTY_NAMES[party]
  end

end
