class MainSearchesController < ApplicationController
  skip_before_filter :authenticate!, :load_search

  def show
    search_params = params[:main_search].symbolize_keys
    @main_search = MainSearch.new(search_params).execute
  end
end
