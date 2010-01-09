ActionController::Routing::Routes.draw do |map|
  map.signup '/signup', :controller => 'authors', :action => 'new', :requirements => {:method => :get}
  map.login '/login', :controller => 'sessions', :action => 'new', :requirements => {:method => :get}
  map.logout '/logout', :controller => 'sessions', :action => 'destroy', :requirements => {:method => :delete}
  
  map.search '/search', :controller => "search", :action => "search", :requirements => {:method => :get}
  
  map.profile '/profile', :controller => "authors", :action => "profile"
  
  map.resources :authors
  map.resource  :session
  map.resources :extensions
  
  map.root :controller => "home", :action => "index"
end
