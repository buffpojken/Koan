require 'active_support/builder'
module Koan  
  module Helper    
    def koan_style_sheet
      
    end    
  end
  
  class KoanPoster    
    
    def self.post(data)
      send_request(data)
    end
        
    private
    
    def self.send_request(data)
      request = RestClient::Request.new({
        :user       => Koan::Engine.config.creds['username'], 
        :password   => Koan::Engine.config.creds['password'], 
        :url        => format_address(Koan::Engine.config.creds['domain']), 
        :payload    => format_ticket(data), 
        :method     => :post, 
        :headers    => {'Accept' => '*/*', 'Content-Type' => 'application/xml'}
      })      
      begin
        response = request.execute
      rescue Exception => e
        puts e.inspect
        logger.error e.inspect
        return false
      end
      return true
    end
    
    def self.format_address(url)
      url = "http://"+url if !url.match(/http/)
      url += "/tickets.xml"
      url
    end
   
   def self.format_ticket(data)
     builder = Builder::XmlMarkup.new(:target => @xml, :ident => 1)
     return builder.ticket do 
       builder.description data[:description]
       builder.tag! 'status-id', 0
       builder.tag! 'ticket-type-id', data[:problem] ? 3 : 1
       builder.tag! 'requester-email', data[:email]
     end
   end
    
  end
end