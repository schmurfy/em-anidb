require 'time'
require 'fiber'

require 'rest-core'
require 'eventmachine'

module EM
  
  module AniDB
    class Client
      Client = RestCore::Builder.client do
        use RestCore::DefaultSite , 'http://api.anidb.net:9001/httpapi'
        use RestCore::CommonLogger, method(:puts)
        use RestCore::Cache       , nil, 3600
        run RestCore::EmHttpRequest
      end
    
      def initialize(app_key)
        @app_key = app_key
        @client = Client.new
      end
      
      def anime(id, &block)
        params = {
          request: "anime",
          client: @app_key,
          clientver: '0',
          protover: '1',
          aid: id
        }
        
        fb = Fiber.current
        
        @client.get("/", params) do |xml|
          fb.resume( Anime.from_string(xml) )
        end
        
        Fiber.yield
      end
      
    end
  end
end
