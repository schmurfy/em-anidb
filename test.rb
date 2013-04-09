require 'rubygems'
require 'bundler/setup'

require 'em-anidb'


# http://api.anidb.net:9001/httpapi?request=anime&client=emanidb&clientver=0&protover=1&aid=8692

EM::run do
  Fiber.new do
    client = EM::AniDB::Client.new('emanidb')
    
    anime = client.anime(8692)
    p anime.title
    similars = anime.similar()
    
    s = client.anime(similars.keys[0])
    p [:similar, s.title]
    
    EM::stop()
  end.resume
  
  # client.search_serie('dead like me') do |series|
  #   client.episodes(series[0].id) do |episodes|
  #     episodes.each do |ep|
  #       puts "Season #{ep.season_number.to_s.rjust(2, '0')} Episode #{ep.episode_number.to_s.rjust(2, '0')} : #{ep.name}  (#{ep.aired_date})"
  #     end
      
  #     EM::stop()
  #   end
    
  # end
  
end

