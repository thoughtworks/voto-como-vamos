VotoComoVamos::Application.routes.draw do
  match '/auth/facebook/callback' => 'sessions#create'
  match '/logout' => 'sessions#destroy'

  resources :candidates do
    resources :proposals, :only => [:new, :create, :show, :destroy, :edit, :update] do
      get :delete
    end
    resources :ownerships
    resources :revindications, :shallow => true,
      :only => [:new, :create, :show]
  end

  resources :proposals

  root :to => 'welcome#index'
end
