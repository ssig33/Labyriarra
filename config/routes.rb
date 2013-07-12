WebTiarra::Application.routes.draw do
  root :to => 'home#index', as: :home
  get "/pc" => "home#pc_mode"
  get "/channel/:id" => "home#channel", as: :channel
  post "/update" => "home#update", as: :update
  get "/next" => "home#next", as: :next
  get "/log/:id/:date" => "home#log", as: :log
  get "/api/update_channels" => "api#update_channels"
  get "/api/unread/:id" => "api#unread"


  get "/sessions" => 'sessions#index'
  post '/sessions' => 'sessions#create'
  #match ':controller(/:action(/:id(.:format)))'
end
