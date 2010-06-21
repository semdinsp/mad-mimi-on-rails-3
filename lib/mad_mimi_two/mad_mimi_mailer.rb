require 'cgi'
require 'rubygems'
gem 'httpclient'
require 'httpclient'
gem 'nokogiri'
require 'nokogiri'
class Hash
  def madmimiurlencode
    to_a.map do |name_value|
      name_value.map { |e| CGI.escape e.to_s }.join '='
    end.join '&'
  end
end
module MadMimiTwo
  module MadMimiMailer
  API_URL = 'https://api.madmimi.com/'
  SINGLE_SEND_URL = "#{API_URL}mailer"
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  def send_cmd(url)
    begin
        client= HTTPClient.new
        res=client.get_content(url)
      rescue HTTPClient::BadResponseError
        res="problem retrieving status"
      end
      res
  end
  def get_promotions_xml
     url="#{API_URL}promotions.xml?#{MadMimiTwo::MadMimiMessage.api_settings.madmimiurlencode}"
     xml_list=send_cmd(url)
  end
  def get_promotions
     xml_list=get_promotions_xml
     res={}
     reader = Nokogiri::XML::Reader(xml_list)
     reader.each do |node|
       res=res.merge({ node.attribute('name') => node.attribute('name') }) if node.name=='promotion' # eventually will want hash
     end
     res
  end
  # check the status of a sent email
  def check_status(msg_id)
    url = "#{SINGLE_SEND_URL}s/status/#{msg_id}?#{MadMimiTwo::MadMimiMessage.api_settings.madmimiurlencode}"
    send_cmd(url)
  end
  
  # Custom Mailer attributes

  def promotion(promo = nil)
    if promo.nil?
      @promotion
    else
      @promotion = promo #promotion
    end
  end

  def use_erb(use_erb = nil)
    if use_erb.nil?
      @use_erb
    else
      @use_erb = use_erb
    end
  end
  def email_placeholders(ep = nil)
     if ep.nil?
       @email_placeholders
     else
       @email_placeholders = ep
     end
   end

  def hidden(hidden = nil)
    if hidden.nil?
      @hidden
    else
      @hidden = hidden
    end
  end
  
  def unconfirmed(value = nil)
    if value.nil?
      @unconfirmed
    else
      @unconfirmed = value
    end
  end
   def deliver_mimi_message()
      mail = self
      return unless perform_deliveries

      if delivery_method == :test
        deliveries << (mail.mail ? mail.mail : mail)
      else
        if (all_recipients = mail[:to]).is_a? Array
          all_recipients.each do |recipient|
            mail.recipients = recipient
            call_api!()
          end
        else
          call_api!()
        end
      end
    end
      def call_api!()
        params = {
          'username' => MadMimiTwo::MadMimiMessage.api_settings[:username],
          'api_key' =>  MadMimiTwo::MadMimiMessage.api_settings[:api_key],
          'promotion_name' => self.promotion, # scott || method.to_s.sub(/^#{method_prefix}_/, ''),
          'recipients' =>     serialize(self[:to].to_s.split(',')),   #removed to_a, needs comma
          'subject' =>        self[:subject].to_s,
          'bcc' =>            serialize(self[:bcc].to_s.split(',') || MadMimiMailer.default_parameters[:bcc]),
          'from' =>           (self[:from].to_s || MadMimiMailer.default_parameters[:from]),
          'hidden' =>         serialize(self.hidden)
        }
        params['body']= self.email_placeholders.to_yaml
# puts "params: #{params.inspect} to string #{params.to_s}"
       #scott  params['unconfirmed'] = '1' if mail.unconfirmed

      #scott)  if use_erb?(mail)
      #scott    if mail.parts.any?
         #scott   params['raw_plain_text'] = content_for(mail, "text/plain")
         #scott   params['raw_html'] = content_for(mail, "text/html") { |html| validate(html.body) }
      #scott    else
      #scott      validate(mail.body)
      #scott      params['raw_html'] = mail.body
      #scott    end
       #scott else
       #scott   stringified_default_body = (MadMimiMailer.default_parameters[:body] || {}).stringify_keys!
       #scott   stringified_mail_body = (mail.body || {}).stringify_keys!
       #scott   body_hash = stringified_default_body.merge(stringified_mail_body)
      #scott    params['body'] = body_hash.to_yaml
      #scott  end

        response = post_request do |request|
          request.set_form_data(params)
        end

        case response
        when Net::HTTPSuccess
          response.body
        else
          response.error!
        end
      end

      def content_for( content_type)
        part = self.parts.detect {|p| p.content_type == content_type }
        if part
          yield(part) if block_given?
          part.body
        end
      end

      def validate(content)
        unless content.include?("[[peek_image]]") || content.include?("[[tracking_beacon]]")
          raise MadMimiMailer::ValidationError, "You must include a web beacon in your Mimi email: [[peek_image]]"
        end
      end

      def post_request
        url = URI.parse(SINGLE_SEND_URL)
        request = Net::HTTP::Post.new(url.path)
        yield(request)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.start do |http|
          http.request(request)
        end
      end

      def serialize(recipients)
        case recipients
        when String
          recipients
        when Array
          recipients.join(", ")
        when NilClass
          nil
        else
          raise "Please provide a String or an Array for recipients or bcc."
        end
      end

      def use_erb?()
        self.use_erb || use_erb
      end
    end

  module ClassMethods
    attr_accessor :method_prefix, :use_erb
    
    def method_missing(method_symbol, *parameters)
      if method_prefix && method_symbol.id2name.match(/^deliver_(#{method_prefix}_[_a-z]\w*)/)
        deliver_mimi_mail($1, *parameters)
      elsif method_prefix.nil? && method_symbol.id2name.match(/^deliver_([_a-z]\w*)/)
        deliver_mimi_mail($1, *parameters)
      else
        super
      end
    end
   
    def deliver_mimi_mail(method, *parameters)
      mail = new
      mail.__send__(method, *parameters)

      if use_erb?(mail)
        mail.create!(method, *parameters)
      end

      return unless perform_deliveries

      if delivery_method == :test
        deliveries << (mail.mail ? mail.mail : mail)
      else
        if (all_recipients = mail.recipients).is_a? Array
          all_recipients.each do |recipient|
            mail.recipients = recipient
            call_api!(mail, method)
          end
        else
          call_api!(mail, method)
        end
      end
    end

  

end
end  #module