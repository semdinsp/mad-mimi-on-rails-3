require 'rubygems'
gem 'mail'
require "mail"
require "net/https"
require 'mad_mimi_mailer'
gem 'activesupport'
require 'active_support/core_ext/class/attribute_accessors'


module MadMimiTwo
class MadMimiMessage < Mail::Message
 

  @@api_settings = {}
  cattr_accessor :api_settings
  
  @@default_parameters = {}
  cattr_accessor :default_parameters
  #promotion =Mail::Field.new('promotion')

  include MadMimiTwo::MadMimiMailer
  self.method_prefix = "mimi"

  class ValidationError < StandardError; end
end
end #module

# Adding the response body to HTTPResponse errors to provide better error messages.
module Net
  class HTTPResponse
    def error!
      message = @code + ' ' + @message.dump + ' ' + body
      raise error_type().new(message, self)
    end
  end
end
