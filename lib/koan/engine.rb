require 'koan'
require 'rails' 


module Koan

  module Helper
    def koan_script
      javascript_include_tag('koan/koan.js')
    end
    def koan_styles
      stylesheet_link_tag('koan/koan.css')
    end
  end
  
  class Engine < Rails::Engine
    
    config.mount_at = 'koan/'
    initializer "koan.assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end
    
    initializer "koan.config" do |app|
      if(File.exists?(File.join(Rails.root, 'config', 'koan.yml')))
        config.creds = YAML::load(File.open(File.join(Rails.root, 'config', 'koan.yml'), 'r+'))[Rails.env]      
      else
        raise NotImplementedError.new("Koan tried to load config/koan.yml but couldn't find the file?")
      end
    end
    
    ActionView::Base.send :include, Koan::Helper
    
  end
end

