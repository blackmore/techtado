require File.join(File.dirname(__FILE__), "..", "lib", "mms2r")
require File.join(File.dirname(__FILE__), "test_helper")
require 'test/unit'
require 'rubygems'
require 'mocha'
gem 'tmail', '>= 1.2.1'
require 'tmail'

class TestMmsNetcomNo < Test::Unit::TestCase
  include MMS2R::TestHelper

  def test_subject
    mail = TMail::Mail.parse(load_mail('netcom-image-01.mail').join)
    mms = MMS2R::Media.new(mail)
    assert_equal "Morning greetings from norway. This is a", mms.subject

    mms.purge
  end

  def test_image
    mail = TMail::Mail.parse(load_mail('netcom-image-01.mail').join)
    mms = MMS2R::Media.new(mail)
  
    assert_equal 2, mms.media.size
    assert_not_nil mms.media['text/plain']
    assert_equal 1, mms.media['text/plain'].size
    assert_not_nil mms.media['image/jpeg']
    assert_equal 1, mms.media['image/jpeg'].size
    assert_file_size mms.media['image/jpeg'].first, 337
  
    mms.purge
  end

  def test_default_media_should_return_user_generated_content
    mail = TMail::Mail.parse(load_mail('netcom-image-01.mail').join)
    mms = MMS2R::Media.new(mail)
    file = mms.default_media
    assert_equal 337, file.size
    
    mms.purge
  end 

  def test_default_text_should_return_user_generated_content
    mail = TMail::Mail.parse(load_mail('netcom-image-01.mail').join)
    mms = MMS2R::Media.new(mail)
    file = mms.default_text
    assert_equal "Morning greetings from norway. This is a mms from norwegian carrier netcom.", file.read
    
    mms.purge
  end 
  
end
