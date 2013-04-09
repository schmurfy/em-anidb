require 'time'
require 'ox'

module EM  
  module AniDB
    
    module XMLHelpers
      def find_text_node(root_element, path, converter = nil)
        tmp = root_element.locate("#{path}/?[0]")
        if tmp
          converter ? tmp[0].send(converter) : tmp[0]
        else
          nil
        end
      end
      
    end
    
    class Episode
      include XMLHelpers
      
      def initialize(data: nil)
        @data = data
      end
      
      def title(lang: 'en')
        @data.locate("title").each do |node|
          if node['xml:lang'] == lang.to_s
           return node.nodes[0] 
          end
        end
      end
      
      def airdate
        date = find_text_node(@data, 'airdate')
        Time.parse(date)
      end

    end
    
    class Anime
      include XMLHelpers
      
      def self.from_string(str)
        new(data: str)
      end
      
      def self.from_xml(xml)
        new(xml: xml)
      end
      
      
      def initialize(data: nil, xml: nil)
        if data
          @data = Ox.load(data)
        else
          @data = xml
        end
        
        @data = @data.locate('anime').first
      end
      
      def title(type: 'official', lang: 'en')
        @data.locate("titles/title").each do |node|
          if (node['xml:lang'] == lang.to_s) && (node['type'] == type)
           return node.nodes[0] 
          end
        end
        
        nil
      end
      
      def rating
        find_text_node(@data, 'ratings/permanent', :to_f)
      end
      
      def started_at
        date = find_text_node(@data, 'startdate')
        Time.parse(date)
      end
      
      def ended_at
        date = find_text_node(@data, 'enddate')
        Time.parse(date)
      end

      def episode_count
        find_text_node(@data, 'episodecount', :to_i)
      end
      
      def related
        @data.locate("relatedanime/anime").inject({}) do |ret, node|
          ret[node['id'].to_i] = node.nodes[0].to_s
          ret
        end
      end
      
      def similar
        @data.locate("similaranime/anime").inject({}) do |ret, node|
          ret[node['id'].to_i] = [node['approval'].to_i, node['total'].to_i, node.nodes[0].to_s]
          ret
        end
      end
      
      def episodes
        @data.locate("episodes/episode").inject({}) do |ret, node|
          epno = find_text_node(node, 'epno', :to_i)
          ret[epno] = Episode.new(data: node)
          ret
        end
      end
      
    end
    
  end
end
