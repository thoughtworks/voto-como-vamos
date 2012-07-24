require "components/opinion_widget"
module OpinionHelper

  def opinion_widget user, proposal
    widget = ::OpinionWidget.new(user, proposal, self)
    render :partial => "opinions/widget", :locals => {:widget => widget}
  end

end
