require 'spec_helper'

describe RevindicationsController do
  before :each do
    controller.stub!(current_user: true)
  end

  describe 'new reivindication' do
    before :each do
      get :new
    end

    it { should respond_with(:success) }
    it { should render_template('new') }
  end
end
