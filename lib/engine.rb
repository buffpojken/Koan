require 'koan'
require 'rails'
require 'action_controller'

module Koan
  class Engine < Rails::Engine
    config.mount_at = 'koan/'

    initializer "static assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end
    
    initializer "config file" do |app|
      if(File.exists?(File.join(Rails.root, 'config', 'koan.yml')))
        config.creds = YAML::load(File.open(File.join(Rails.root, 'config', 'koan.yml'), 'r+'))[Rails.env]      
      else
        raise NotImplementedError.new("Koan tried to load config/koan.yml but couldn't find the file?")
      end
    end
    
  end
end