module Koan
  class KoanController < ActionController::Base

    before_filter :current_user, :only => [:create]
    
    def show
      render :text => "This is not a supported method", :status => 405 and return
    end
    
    def new
      
    end
    
    def create
      params[:feedback].merge("requester-email" => @current_user.email) if @current_user
      if Koan::Poster.post(params[:feedback])
        render :text => {:error => false, :message => "We'll get back to you shortly!"}.to_json, :status => 200 and return
      else
        render :text => {:error => true, :message => "Something must have gone wrong, try again!"}.to_json, :status => 500 and return
      end
    end
    
  end  
end