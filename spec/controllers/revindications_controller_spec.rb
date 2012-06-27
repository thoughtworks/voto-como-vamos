require 'spec_helper'

describe RevindicationsController do
  let(:current_user) { mock_model(User) }
  let(:candidate) { double('candidate') }
  let(:revindication) { double('revindication') }

  before :each do
    controller.stub!(current_user: current_user)
  end

  describe 'new' do
    before :each do
      Candidate.
        should_receive(:find).
        with('1').
        and_return(candidate)

      Revindication.
        should_receive(:new).
        and_return(revindication)

      get :new, candidate_id: '1'
    end

    it { should assign_to(:revindication).with(revindication) }
    it { should respond_with(:success) }
    it { should render_template('new') }
  end

  describe 'show' do
    before :each do
      Revindication.
        should_receive(:find).
        with('1').
        and_return(revindication)
      get :show, id: '1'
    end

    it { should assign_to(:revindication).with(revindication) }
    it { should respond_with(:success) }
    it { should render_template('show') }
  end

  describe 'creating' do
    let(:fake_params) do
        { :candidate_id  => '1',
          :revindication => {} }
    end

    before :each do
       Candidate.
        should_receive(:find).
        with('1').
        and_return(candidate)

      Revindication.
        should_receive(:new).
        with(fake_params[:revindication]).
        and_return(revindication)

      revindication.should_receive(:user=).with(current_user)
      revindication.should_receive(:candidate=).with(candidate)
    end

    context 'successfully' do
      before :each do
        revindication.should_receive(:save).and_return(true)
        post :create, fake_params
      end
      it { should redirect_to( revindication_path(revindication) ) }
    end

    context 'with fail' do
      before :each do
        revindication.should_receive(:save).and_return(false)
        post :create, fake_params
      end
      it { should render_template('new') }
    end
  end
end
