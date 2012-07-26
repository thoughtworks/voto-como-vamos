class OpinionWidget

  attr_accessor :agreements, :disagreements

  def initialize user, proposal, context
    @user = user
    @proposal = proposal
    @context = context
    @agreements = Opinion.agreements(@proposal).size
    @disagreements = Opinion.disagreements(@proposal).size
  end

  def link_for opinion, image
    value = (opinion == :agree) ? Opinion::AGREE : Opinion::DISAGREE
    opinion_state = opinion_matches? opinion

    if opinion_state.nil?
      @context.link_to image, @context.new_opinion_path(params_for(value))
    elsif opinion_state
      @context.link_to image, @context.opinion_path(current_opinion.id), method: :delete, class: "selected"
    else
      @context.link_to image, @context.edit_opinion_path(current_opinion.id, params_for(value))
    end
  end

  private

  def opinion_matches? opinion
    return nil unless current_opinion
    return current_opinion.agree? if opinion == :agree
    current_opinion.disagree?
  end

  def current_opinion
    @current_opinion = Opinion.opinion_for(@proposal, @user) unless @fetched
    @fetched = true
    @current_opinion
  end

  def params_for opinion
    { opinion: {
      proposal_id: @proposal.id,
      value: opinion
    }}
  end
end
