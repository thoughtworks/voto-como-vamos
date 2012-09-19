# encoding: utf-8
require 'spec_helper'

describe CommentsController do
  let(:proposal) { FactoryGirl.create(:proposal) }
  let(:fb_comment_id) { '12345' }

  before do
    user = FactoryGirl.create(:user)
    controller.stub!(:current_user).and_return(user)
  end

  describe "creating" do
    it "creates a comment for specified proposal"  do
      expect {
        post :create, {
          :proposal_id => proposal.id,
          :fb_comment_id => fb_comment_id }
      }.to change(Comment, :count).by(1)
      should respond_with(:success)
    end
  end
end
