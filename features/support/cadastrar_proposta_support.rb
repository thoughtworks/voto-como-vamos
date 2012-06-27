# encoding: utf-8

module CadastrarPropostaSupport
  def fill_proposal_form_with(proposal)
    within 'form.new_proposal' do
      fill_in 'proposal_title', :with => proposal.title
      fill_in 'proposal_abstract', :with => proposal.abstract
      fill_in 'proposal_description', :with => proposal.description
      find('input[type="submit"]').click
    end
  end
end

World(CadastrarPropostaSupport)
