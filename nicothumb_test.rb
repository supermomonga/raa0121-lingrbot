ENV['RACK_ENV'] = 'test'

require_relative 'nicothumb'
require 'rspec'

describe 'The Thumb' do
  before(:each) do
    @thumb = Nicothumb.new
  end

  describe 'pixiv' do
    context 'user illust list' do
      subject { @thumb.get_image_url('http://www.pixiv.net/member_illust.php?id=747452') }
      it { should be_a_kind_of(Hash) }
      it { should include(:mode => :gyazo) }
      it { should have_key(:url) }
      it { should have_key(:pre_text) }
    end

    context 'illust medium' do
      subject { @thumb.get_image_url('http://www.pixiv.net/member_illust.php?mode=medium&illust_id=37361700') }
      it { should be_a_kind_of(Hash) }
      it { should include(:mode => :gyazo) }
      it { should have_key(:url) }
    end

    context 'illust big' do
      subject { @thumb.get_image_url('http://www.pixiv.net/member_illust.php?mode=big&illust_id=37361700') }
      it { should be_a_kind_of(Hash) }
      it { should include(:mode => :gyazo) }
      it { should have_key(:url) }
    end

    context 'illust medium (manga)' do
      subject { @thumb.get_image_url('http://www.pixiv.net/member_illust.php?mode=medium&illust_id=37979251') }
      it { should be_a_kind_of(Hash) }
      it { should include(:mode => :gyazo) }
      it { should have_key(:url) }
    end

    context 'illust manga' do
      subject { @thumb.get_image_url('http://www.pixiv.net/member_illust.php?mode=manga&illust_id=37979251') }
      it { should be_a_kind_of(Hash) }
      it { should include(:mode => :gyazo) }
      it { should have_key(:url) }
    end

    context 'illust manga big' do
      subject { @thumb.get_image_url('http://www.pixiv.net/member_illust.php?mode=manga_big&illust_id=37979251&page=5') }
      it { should be_a_kind_of(Hash) }
      it { should include(:mode => :gyazo) }
      it { should have_key(:url) }
    end
  end

  describe 'nicovideo' do
    subject { @thumb.get_image_url('http://www.nicovideo.jp/watch/sm9') }
    it { should be_a_kind_of(String) }
  end

  describe 'Twitpic' do
    subject { @thumb.get_image_url('http://twitpic.com/cvze6i') }
    it { should be_a_kind_of(String) }
  end

  describe 'seiga.nicovideo' do
    subject { @thumb.get_image_url('http://seiga.nicovideo.jp/seiga/im1667353?track=ranking') }
    it { should be_a_kind_of(String) }
  end

  describe 'pic.twitter.com' do
    subject { @thumb.get_image_url('https://twitter.com/sora_h/status/317900657661194240/photo/1') }
    it { should be_a_kind_of(String) }
  end

  describe 'Gravatar' do
    context 'exist' do
      subject { @thumb.get_image_url('unmoremaster@gmail.com') }
      it { should be_a_kind_of(String) }
      it { should_not be_empty }
    end

    context 'not found' do
      subject { @thumb.get_image_url('unko@ibm.com') }
      it { should be_a_kind_of(String) }
      it { should_not be_empty }
    end
  end

  describe 'ameba blog' do
    before do
      @url = 'http://stat.ameba.jp/user_images/20130816/13/nakagawa-shoko/9e/46/j/o0321042712649574460.jpg'
    end
    subject { @thumb.get_image_url(@url) }
    it { should be_a_kind_of(Hash) }
    it { should include(:mode => :gyazo, :url => @url, :referer => 'http://ameblo.jp/') }
  end

  describe 'sugoi' do
    context 'ameba blog with Gyazo' do
      subject { @thumb.do_maji_sugoi('http://stat.ameba.jp/user_images/20130816/13/nakagawa-shoko/9e/46/j/o0321042712649574460.jpg') }
      it { should be_a_kind_of(String) }
      it { should match(/^http:\/\/cache\.[^\/]+\/.+\.png$/) }
    end

    context 'user illust list with Gyazo' do
      subject { @thumb.do_maji_sugoi('http://www.pixiv.net/member_illust.php?id=747452') }
      it { should be_a_kind_of(String) }
      it { should match(/^.*\nhttp:\/\/cache\.[^\/]+\/.+\.png$/) }
    end

    context 'illust medium with Gyazo' do
      subject { @thumb.do_maji_sugoi('http://www.pixiv.net/member_illust.php?mode=medium&illust_id=37361700') }
      it { should be_a_kind_of(String) }
      it { should match(/http:\/\/cache\.[^\/]+\/.+\.png$/) }
    end
  end
end
