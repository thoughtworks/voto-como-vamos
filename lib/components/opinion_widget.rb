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
      h.content_tag(:span, @opinion.agreements(@proposal).size, class: "agreed") <<
      link_for(:agree) <<
      h.content_tag(:span, @opinion.disagreements(@proposal).size, class: "disagreed") <<
      link_for(:disagree)
    end
  end

  private
  def link_for opinion

    value = (opinion == :agree) ? Opinion::AGREE : Opinion::DISAGREE
    opinion_state = opinion_matches? opinion

    if opinion_state.nil?
      h.link_to t("opinion.#{opinion}"),
                new_opinion_path(params_for(value)),
                class: class_for(opinion)

    elsif opinion_state
      h.link_to t("opinion.#{opinion}"),
                opinion_path(current_opinion.id),
                class: class_for(opinion),
                method: :delete

    else
      h.link_to t("opinion.#{opinion}"),
                edit_opinion_path(current_opinion.id, params_for(value)),
                class: class_for(opinion)
    end

  end

  def class_for opinion
    opinion_matches?(opinion) ? "#{opinion} highlight" : opinion.to_s
  end

  def opinion_matches? opinion
    return nil unless current_opinion
    return current_opinion.agree? if opinion == :agree
    current_opinion.disagree?
  end

  def current_opinion
    @current_opinion = @opinion.opinion_for(@proposal, @user) unless @fetched
    @fetched = true
    @current_opinion
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
