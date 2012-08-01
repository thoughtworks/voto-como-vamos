VotoComoVamos::Application.routes.draw do

  match '/auth/facebook/callback' => 'sessions#create'
  match '/auth/logged_in' => 'sessions#logged_in'
  match '/logout' => 'sessions#destroy'
  match '/propostas/aleatorias' => 'proposals#random_listing'
  match '/credits' => 'welcome#credits'

  scope :scope_paths => { :new => "novo", :edit => "editar" } do
    resources :candidates, :path => "candidatos" do
      resources :proposals, :path => "propostas", :only => [:new, :create, :show, :destroy, :edit, :update] do
        get :delete
      end
      resources :ownerships
      resources :revindications, :shallow => true,
        :only => [:new, :create, :show]
    end
  
    resources :proposals, :path => "propostas", :only => [:index, :show] do
      resources :questions, :only => [] do
        get :create, :on => :collection
      end
    end
    
    resources :opinions, :path => "opinioes"
  end

  resources :parties, :path => "partidos", :only => [:index, :show]

  resource :main_search
  root :to => 'welcome#index'
  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end
end
