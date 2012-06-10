VotoComoVamos::Application.routes.draw do
  match '/auth/facebook/callback' => 'sessions#create'
  match '/logout' => 'sessions#destroy'
  root :to => 'welcome#index'
end
