#!/usr/bin/ruby
# == Synopsis
#   send mad mimi email 
# == Usage
#  send_mimi.rb  -e email -p promotion   -k key -u mimiusername -h hashvalues -s subject
# == Author
#   Scott Sproule  --- Ficonab.com (scott.sproule@ficonab.com)
# == Example
# send_mimi.rb -e xxxx@ficonab.com -p new_crm -k xxxx -u xxxx@estormtech.com -s testing -h "{:user => 'test', :url => 'test.estormtech.com' }"
# == Copyright
#    Copyright (c) 2010 Ficonab Pte. Ltd.
#     See license for license details
require 'yaml'
require 'rubygems'
gem 'mad_mimi_two'
require 'mad_mimi_two'
require 'optparse'
require 'rdoc/usage'
#require 'java' if RUBY_PLATFORM =~ /java/
# start the processing
 arg_hash=MadMimiTwo::Options.parse_options(ARGV)
 RDoc::usage if arg_hash[:help]==true
require 'pp'

  options = arg_hash
   # set up variables using hash
   # note the strange spacing needed to put the ' in the string
   MadMimiTwo::MadMimiMessage.api_settings = {
         :username => options[:username].to_s,
         :api_key => options[:key].to_s
       }
     thash=eval(options[:hashvalues])    # THIS IS KLUDGE expecting ruby String like "{:user => 'test', :url => 'test.estormtech.com' }"
     t=MadMimiTwo::MadMimiMessage.new do
       subject    options[:subject]
       to  options[:email]
     #  cc          admin
       promotion   options[:promotion]
       from       options[:from] || 'support@estormtech.com'
       bcc        ["scott.sproule@estormtech.com"]
      # sent_on    Time.now
       email_placeholders       thash  # :user => tuser, :url => turl 
       content_type "text/html"
     end
  #   t.email_placeholders(thash)
     r=t.deliver_mimi_message
     puts r