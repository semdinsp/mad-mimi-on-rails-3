require File.dirname(__FILE__) + '/test_helper.rb'

class TestMadMimiTwo < Test::Unit::TestCase

  def setup
    # MadMimiTwo::MadMimiMessage.api_settings = {
    #     :username => 'xxx@estormtech.com',
   #     :api_key => 'insesert your api key here'
   #   }
    require 'api_key'   #or put it in this file
  end

  def test_initial_class
    t=MadMimiTwo::MadMimiMessage.new
    puts t.inspect
    assert t.headers.size==0, "headers not empty"
  end
  def test_header
     test="hello there"
    hashv={ :body => test, :user => 'string'}
    t=MadMimiTwo::MadMimiMessage.new do
      subject    'email from test case: test_header'
      to 'scott.sproule@ficonab.com'
    #  cc          admin
      promotion   'new_crm'
      from       'support@estormtech.com'
      bcc        ["scott.sproule@estormtech.com", "eka.mardiarti@estormtech.com"]
     # sent_on    Time.now
      email_placeholders       hashv  # :user => tuser, :url => turl 
      content_type "text/html"
    end
    puts t.inspect
    assert t.headers.size==0, "headers not empty"
    assert t[:to].to_s=='scott.sproule@ficonab.com', "to person not correct #{t[:to]}"
    assert t.promotion.to_s=='new_crm', 'promotion first wrong'
    assert t.email_placeholders.has_key?(:body), "placeholders seem wrong #{t.email_placeholders}"
     assert t.email_placeholders.value?("hello there"), "placeholders seem wrong #{t.email_placeholders}"
    #assert t[:promotion].to_s=='new_crm', 'promotion wrong'
  end
  def test_header_setup2
    test="hello there"
    t=MadMimiTwo::MadMimiMessage.new do
      subject    'email from test case: test_header_setup2'
      to 'scott.sproule@ficonab.com'
    #  cc          admin
      promotion   'new_crm'
      from       'support@estormtech.com'
      bcc        ["scott.sproule@estormtech.com", "eka.mardiarti@estormtech.com"]
     # sent_on    Time.now
      email_placeholders      :body => test, :user => 'string'
      content_type "text/html"
    end
    puts t.inspect
    assert t.email_placeholders.has_key?(:body), "placeholders seem wrong #{t.email_placeholders}"
     assert t.email_placeholders.value?("hello there"), "placeholders seem wrong #{t.email_placeholders}"
    #assert t[:promotion].to_s=='new_crm', 'promotion wrong'
  end
  def test_sending_mesage # PLEASE NOTE THAT YOUR MAD MIMI ACCOUNT NEEDS PROMOTION CALLED new_crm accepting  user and url
    thash={:user => 'test', :url => 'test.estormtech.com' } 
    t=MadMimiTwo::MadMimiMessage.new do
      subject    'email from test case: test_sending_message'
      to 'scott.sproule@ficonab.com'
    #  cc          admin
      promotion   'new_crm'
      from       'support@estormtech.com'
      bcc        ["scott.sproule@estormtech.com", "eka.mardiarti@estormtech.com"]
     # sent_on    Time.now
      email_placeholders       thash  # :user => tuser, :url => turl 
      content_type "text/html"
    end
 #   t.email_placeholders(thash)
    r=t.deliver_mimi_message
    puts "result: #{r} message:  #{t.inspect}"
    assert t.headers.size==0, "headers not empty"
    assert t[:to].to_s=='scott.sproule@ficonab.com', "to person not correct #{t[:to]}"
    assert t.promotion.to_s=='new_crm', 'promotion first wrong'
    #assert t[:promotion].to_s=='new_crm', 'promotion wrong'
  end
  def test_check_status
   # puts "message id: 1159748168"   (old message id)  PUT IN ONE OF YOUR MESSAGE IDs to check
    t=MadMimiTwo::MadMimiMessage.new
    r=t.check_status('1159748168')
    puts "'r is ' #{r}"
    assert r.class==String, "response is not string r is: #{r} #{r.class}"
    assert r=='sent', "message response not correct: #{r}"
     
  end
end