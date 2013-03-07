WebTiarra::Application.routes.draw do
  root :to => 'home#index', as: :home
  match "/pc" => "home#pc_mode"
  match "/channel/:id" => "home#channel", as: :channel
  post "/update" => "home#update", as: :update
  match "/next" => "home#next", as: :next
  match "/log/:id/:date" => "home#log", as: :log
  match "/api/update_channels" => "api#update_channels"
  match "/api/unread/:id" => "api#unread"


  get "/sessions" => 'sessions#index'
  post '/sessions' => 'sessions#create'
  #match ':controller(/:action(/:id(.:format)))'
end
