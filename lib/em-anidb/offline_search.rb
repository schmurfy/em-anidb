require 'ox'

module EM
  
  module AniDB
    Found = Class.new(RuntimeError)
    
    class PartialSearchParser < Ox::Sax
      attr_reader :ret
      
      def initialize(str)
        super()
        @search_string = str
        @in_title_node = false
        @ret = {}
      end
      
      def start_element(name)
        @in_title_node = (name == :title)
      end
      
      def attr(name, value)
        if name == :aid
          @current_id = value.to_i
        end
      end
      
      def text(value)
        if value.include?(@search_string)
          @ret[@current_id] = value
        end
      end

    end
    
    class SearchParser < Ox::Sax
      attr_reader :current_id
      
      def initialize(search_string)
        super()
        @current_id = nil
        @search_string = search_string
        
        @in_title_node = false
      end
      
      def start_element(name)
        @in_title_node = (name == :title)
      end
      
      # def end_element(name)
        
      # end
      
      def attr(name, value)
        if name == :aid
          @current_id = value.to_i
        end
      end
      
      def text(value)
        if @search_string == value
          raise Found
        end
      end
      
      
    end
    
    #
    # You need a copy of http://anidb.net/api/anime-titles.xml.gz to use this
    # class
    class OffLineSearch
      def initialize(path)
        @path = path
      end
      
      def search(name)
        parser = SearchParser.new(name)
        Ox.sax_parse(parser, File.open(@path))
        nil
      rescue Found
        parser.current_id
      end
      
      def search_partial(str)
        parser = PartialSearchParser.new(str)
        Ox.sax_parse(parser, File.open(@path))
        parser.ret
      end
      
    end
  end
  
end
