#!/usr/bin/ruby
# == Synopsis
#   send mad mimi email 
# == Usage
#  send_mimi.rb  -e email -p promotion   -k key -u mimiusername -h hashvalues -s subject
# == Author
#   Scott Sproule  --- Ficonab.com (scott.sproule@ficonab.com)
# == Example
# send_mimi.rb  -k xxxx -u xxxx@estormtech.com -s ID 
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
   
     t=MadMimiTwo::MadMimiMessage.new 
     r= t.check_status(options[:subject])
     puts "Status #{r}"
  #   t.email_placeholders(thash)
  #   r=t.deliver_mimi_message
   #  puts r