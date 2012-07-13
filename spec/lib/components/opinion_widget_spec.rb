require 'spec_helper'
require "components/opinion_widget"

describe OpinionWidget do

  let(:user) { mock_model User }
  let(:proposal) { mock_model Proposal }
  let(:opinion) { double "Opinion" }
  let(:widget) { OpinionWidget.new user, proposal, opinion }

  before do
    opinion.stub :opinion_for => nil
    opinion.stub :agreements => []
    opinion.stub :disagreements => []
  end

  context "without opinion" do

    it "should render the default options" do
      widget.render.should include "class=\"agree\""    
      widget.render.should include "class=\"disagree\""    
    end

  end

  context "when agreed" do
    let (:agreed) { Opinion.new :value => Opinion::AGREE }
    let(:agreements) { [agreed] }


    before do
      opinion.stub :opinion_for => agreed
      opinion.stub :agreements => agreements
    end

    it "should render the opinion as highlighted" do
      widget.render.should include "class=\"agree highlight\""    
      widget.render.should include "class=\"disagree\""    
    end

    it "should render the total agreements" do
      widget.render.should include "class=\"agreed\""
      widget.render.should include "1"
    end

  end

  context "when disagreed" do
    let (:disagreed) { Opinion.new :value => Opinion::DISAGREE }
    let(:disagreements) { [disagreed] }
    before do
      opinion.stub :opinion_for => disagreed
      opinion.stub :disagreements => [disagreed]
    end

    it "should render the opition as highlighted" do
      widget.render.should include "class=\"agree\""    
      widget.render.should include "class=\"disagree highlight\""    
    end

    it "should render the disagreements" do
      widget.render.should include "class=\"disagreed\""
      widget.render.should include "1"
    end
  end

end
