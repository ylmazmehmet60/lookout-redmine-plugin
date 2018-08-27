get 'projects/:id/lookouts', :to => 'lookouts#index', :as => 'lookouts'
get 'projects/:id/popups/time_issue', :to => 'popups#time_issue'
get 'projects/:id/popups/time_user', :to => 'popups#time_user' , :as => 'timeuser'

match 'shared/issues', :controller => 'issues_api', :action => 'index', :via => [:get]
