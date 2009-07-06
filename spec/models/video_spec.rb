require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Video do
  before(:each) do
    @valid_attributes = {
      :title => "test film.avi",
      :length => "2'12",
      :customer_id => 1,
      :source_media => "digital"
    }
  end

  it "should not validate with no length" do
    video = Video.new(@valid_attributes)
    video.length = nil
    video.save.should_not eql(true)
  end
  
  it "should validate with a digit" do
    video = Video.new(@valid_attributes)
    video.length = 2
    video.save.should eql(true)
  end
  
  it "should not validat with a string" do
    video = Video.new(@valid_attributes)
    video.length = "string"
    video.save.should_not eql(true)
  end
  
  it "should validate with number and string" do
    video = Video.new(@valid_attributes)
    video.length = "6'"
    video.save
    video.length.should == "6'"
  end
  
  it "should validate and add minute symb" do
    video = Video.new(@valid_attributes)
    video.length = "6"
    video.save
    video.length.should == "6'"
  end
  
  it "should validate and add minute symb" do
    video = Video.new(@valid_attributes)
    video.length = "6:30"
    video.save
    video.length.should == "6'30"
  end
  
  it "should validate and add minute symb" do
    video = Video.new(@valid_attributes)
    video.length = "6:30''"
    video.save
    video.length.should == "6'30"
  end
  
end
