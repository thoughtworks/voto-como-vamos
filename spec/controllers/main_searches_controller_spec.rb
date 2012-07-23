require 'spec_helper'

describe MainSearchesController do
  describe 'showing results' do
    it 'should search based on a query' do
      fake_params = { :main_search => { :query => 'test' , :candidates_page => nil, :proposals_page => nil } }

      main_search = double('Main Search')
      main_search.should_receive(:execute)
      MainSearch.should_receive(:new).with(fake_params[:main_search]).and_return(main_search)

      get :show, fake_params
      should render_template('show')
    end
  end
end
