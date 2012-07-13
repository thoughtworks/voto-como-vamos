class OpinionWidget

  include ActionView::Helpers::TagHelper
  include Rails.application.routes.url_helpers

  def initialize user, proposal, opinion = Opinion
    @user = user
    @proposal = proposal
    @opinion = opinion
  end


  def render
    h.content_tag :div, id: :opinion do
      h.content_tag(:span, @opinion.agreements.size, class: "agreed") <<
      h.link_to(t('opinion.agree'),
                new_opinion_path(params_for(Opinion::AGREE)),
                class: class_for(:agree)) <<
      h.content_tag(:span, @opinion.disagreements.size, class: "disagreed") <<
      h.link_to(t('opinion.disagree'),
                new_opinion_path(params_for(Opinion::DISAGREE)),
                class: class_for(:disagree))
    end
  end

  private
  def class_for opinion
    opinion_matches?(opinion) ? "#{opinion} highlight" : opinion.to_s
  end

  def opinion_matches? opinion
    current_opinion = @opinion.opinion_for(@proposal, @user)

    return false unless current_opinion
    return current_opinion.agree? if opinion == :agree
    current_opinion.disagree?
  end


  def params_for opinion
    { opinion: {
     proposal_id: @proposal.id,
     value: opinion
    }}
  end

  def h
    ApplicationController.helpers
  end

  def t text
    h.t text
  end
end
