require File.expand_path('../../spec_helper', __FILE__)

describe 'Offline Search' do
  before do
    path = File.expand_path('../../data/anime-titles.xml', __FILE__)
    @search = EM::AniDB::OffLineSearch.new(path)
  end
  
  should 'find anime by exact name' do
    ret = @search.search('SAO')
    ret.should == 8692
  end
  
  should 'find anime by exact name(utf8)' do
    ret = @search.search('銀河へキックオフ!!')
    ret.should == 8923
  end
  
  should 'find animes by partial name' do
    ret = @search.search_partial('Crest')
    ret.size.should == 5
    ret.should == {
      1    => "Crest of the Stars",
      6    => "Crest of the Stars: Fragment Birth of Stars",
      1623 => "Crest of the Stars Movie",
      2095 => "Dragon Quest: Crest of Roto",
      2790 => "Gude Crest - The Emblem of Gude"
    }
  end
end
