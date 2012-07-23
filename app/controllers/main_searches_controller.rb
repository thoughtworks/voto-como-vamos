class MainSearchesController < ApplicationController
  skip_before_filter :authenticate!, :load_search

  def show
    search_params = params[:main_search].symbolize_keys
    search_params[:candidates_page] = params[:candidates_page]
    search_params[:proposals_page] = params[:proposals_page]
    @main_search = MainSearch.new(search_params).execute
  end
end
