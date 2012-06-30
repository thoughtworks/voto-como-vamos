VotoComoVamos::Application.routes.draw do
  match '/auth/facebook/callback' => 'sessions#create'
  match '/logout' => 'sessions#destroy'

  resources :candidates do
    resources :proposals, :only => [:new, :create, :show, :destroy] do
      get :delete
    end
    resources :revindications, :shallow => true,
      :only => [:new, :create, :show]
  end

  root :to => 'welcome#index'
end
