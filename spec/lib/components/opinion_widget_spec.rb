require 'spec_helper'
require "components/opinion_widget"

describe OpinionWidget do

  include Rails.application.routes.url_helpers

  let(:user) { mock_model User }
  let(:proposal) { mock_model Proposal }
  let(:template_context) {double "Template"}
  let(:widget) { OpinionWidget.new user, proposal, template_context }

  before do
    proposal.stub :id => 1
  end

  context "without opinion" do
    let(:agree_params) { {opinion: {
      proposal_id: 1,
      value: Opinion::AGREE
    }}}
    let(:disagree_params) { {opinion: {
      proposal_id: 1,
      value: Opinion::DISAGREE
    }}}

    before do
      Opinion.should_receive(:opinion_for).and_return(nil)
      Opinion.should_receive(:agreements).and_return([])
      Opinion.should_receive(:disagreements).and_return([])
    end

    it "should link to add agree opinions" do
      template_context.should_receive(:new_opinion_path).with(agree_params).and_return('path')
      template_context.should_receive(:link_to).with('name', 'path')

      widget.link_for :agree, 'name'
    end

    it "should link to add agree opinions" do
      template_context.should_receive(:new_opinion_path).with(disagree_params).and_return('path')
      template_context.should_receive(:link_to).with('name', 'path')

      widget.link_for :disagree, 'name'
    end

  end

  context "when agreed" do
    let (:agreed) { Opinion.new :value => Opinion::AGREE, :id => 1 }
    let(:agreements) { [agreed] }


    before do
      Opinion.should_receive(:agreements).and_return(agreements)
      Opinion.should_receive(:disagreements).and_return([])
    end

    it "should know the total agreements" do
      widget.agreements.should eql 1
    end

    it "should link to the delete url" do
      Opinion.should_receive(:opinion_for).and_return(agreed)
      template_context.should_receive(:opinion_path).with(1).and_return('path')
      template_context.should_receive(:link_to).with('name', 'path', method: :delete, class: "selected")

      widget.link_for :agree, 'name'
    end
  end

  context "when disagreed" do
    let (:disagreed) { Opinion.new :value => Opinion::DISAGREE, :id => 1 }
    let(:disagreements) { [disagreed] }

    before do
      Opinion.should_receive(:agreements).and_return([])
      Opinion.should_receive(:disagreements).and_return(disagreements)
    end

    it "should know the disagreements" do
      widget.disagreements.should eql 1
    end

    it "should render the delete url" do
      Opinion.should_receive(:opinion_for).and_return(disagreed)
      template_context.should_receive(:opinion_path).with(1).and_return('path')
      template_context.should_receive(:link_to).with('name', 'path', method: :delete, class: "selected")

      widget.link_for :disagree, 'name'
    end

  end

end
