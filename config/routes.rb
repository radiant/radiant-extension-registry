ActionController::Routing::Routes.draw do |map|
  map.signup '/signup', :controller => 'authors', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy', :requirements => {:method => :delete}
  
  map.search '/search', :controller => "search", :action => "search"
  
  map.resources :authors
  map.resource  :session
  map.resources :extensions
  
  map.root :controller => "home", :action => "index"
end
