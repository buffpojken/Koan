module Koan
  class KoanController < ApplicationController
    
    def show
      render :text => "This is not a supported method", :status => 405 and return
    end
    
    def create
      if Koan::Poster.post(params[:feedback])
        render {:error => false, :message => "We'll get back to you shortly!"}.to_json, :status => 200 and return
      else
        render {:error => true, :message => "Something must have gone wrong, try again!"}.to_json, :status => 500 and return
      end
    end
    
  end  
end