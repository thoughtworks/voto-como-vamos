# encoding: utf-8

class ProposalsController < ApplicationController

  inherit_resources

  respond_to :html, :only => :new

  belongs_to :candidate

end
