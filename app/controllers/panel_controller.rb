# encoding: utf-8

class PanelController < ApplicationController
  def show
    @candidates = Candidate
    @proposals = Proposal
    @users = User
    @owners = Ownership
  end
end
