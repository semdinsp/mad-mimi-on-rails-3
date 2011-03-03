#!/usr/bin/ruby
usage=<<EOF_USAGE

# == Synopsis
#   send mad mimi email 
# == Usage
#  add_to_list.rb  -e email -l listname   -k key -u mimiusername 
# == Author
#   Scott Sproule  --- Ficonab.com (scott.sproule@ficonab.com)
# == Example
# add_to_list.rb  -k xxxx -u xxxx@estormtech.com -l listname -e destination@mail.com
# == Copyright
#    Copyright (c) 2010 Ficonab Pte. Ltd.
#     See license for license details
EOF_USAGE

require 'yaml'
require 'rubygems'
gem 'mad_mimi_two'
require 'mad_mimi_two'
require 'optparse'
#require 'java' if RUBY_PLATFORM =~ /java/
# start the processing
 arg_hash=MadMimiTwo::Options.parse_options(ARGV)
 MadMimiTwo::Options.show_usage_exit(usage) if arg_hash[:help]==true

require 'pp'

  options = arg_hash
   # set up variables using hash
   # note the strange spacing needed to put the ' in the string
   MadMimiTwo::MadMimiMessage.api_settings = {
         :username => options[:username].to_s,
         :api_key => options[:key].to_s
       }
  t=MadMimiTwo::MadMimiMessage.new
  r=t.add_email(options[:list],options[:email])
  puts "status is #{r} for email #{options[:email]} and list: #{options[:list]}"