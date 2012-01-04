Rails.application.routes.draw do |map|

  mount_at = Koan::Engine.config.mount_at

  match mount_at => 'koan/koan#show'
  
  scope 'koan' do 
    resource :issues, :controller => "koan/koan", :path_prefix => "koan", :only => [:create, :new, :show]
  end
  
end
