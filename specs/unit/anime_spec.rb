require File.expand_path('../../spec_helper', __FILE__)

describe 'Anime Parser' do
  before do
    @data_file = File.read(File.expand_path('../../data/sao.xml', __FILE__))    
    @anime = EM::AniDB::Anime.from_string(@data_file)
  end
  
  describe 'SAO' do    
    should 'extract titles' do
      @anime.title.should == "Sword Art Online"
      @anime.title(lang: 'ja').should == "ソードアート・オンライン"
    end
    
    should 'extract episodecount' do
      @anime.episode_count.should == 25
    end
    
    should 'extract dates' do
      @anime.started_at.should == Time.parse('2012-06-24')
      @anime.ended_at.should == Time.parse('2012-12-23')
    end
    
    should 'extract related animes' do
      @anime.related.should == {
        8691 => "Accel World"
      }
    end
    
    should 'extract similar anime' do
      @anime.similar.should == {
        24 => [150, 175, ".hack//SIGN"],
        5503 => [97, 120, "Druaga no Tou: the Aegis of Uruk"],
        4324 => [23, 29, ".hack//Roots"],
        7883 => [8, 14, ".hack//Quantum"],
        545 => [5, 13, "Hunter x Hunter: Greed Island"],
        1523 => [4, 10, "Ragnarok the Animation"]
      }
    end
    
    should 'extract rating' do
      @anime.rating.should == 7.51
    end
    
    should 'extract episodes' do
      @anime.episodes[1].class.should == EM::AniDB::Episode
      @anime.episodes[1].title.should == "The World of Swords"
      @anime.episodes[1].title(lang: 'ja').should == "剣の世界"
      @anime.episodes[1].airdate.should == Time.parse("2012-06-24")
    end
    
  end
  
  
  describe '.Hack' do
    before do
      @data_file = File.read(File.expand_path('../../data/hack.xml', __FILE__))
      @anime = EM::AniDB::Anime.from_string(@data_file)
    end
    
    should 'extract titles' do
      @anime.title.should == nil
      @anime.title(lang: 'ja').should == ".hack//SIGN"
    end

  end
  
end
