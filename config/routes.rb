VotoComoVamos::Application.routes.draw do
  match '/auth/facebook/callback' => 'sessions#create'
  match '/logout' => 'sessions#destroy'

  resources :candidates do
    resources :proposals, :only => :new
  end

  root :to => 'welcome#index'
end
