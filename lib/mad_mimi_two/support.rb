require 'optparse'
require 'rdoc/usage'


module MadMimiTwo
  class Options
    def self.parse_options(params)
       opts = OptionParser.new
    #   puts "argv are #{params}"
       temp_hash = {}
        opts.on("-u","--username VAL", String) {|val|  temp_hash[:username] = val
                                                puts "# mad mimi username is #{val}"   }
           opts.on("-e","--email VAL", String) {|val|  temp_hash[:email] = val
                                 puts "# email is #{temp_hash[:email]}"   }
      opts.on("-h","--hashvalues VAL", String) {|val|  temp_hash[:hashvalues] = val
                         puts "# hashvalues are #{temp_hash[:hashvalues]}"    }                                        
       opts.on("-p","--promotion VAL", String) {|val|  
                                                 temp_hash[:promotion] = val
                                                puts "# promotion is #{temp_hash[:promotion]}"         }  
          opts.on("-f","--from VAL", String) {|val|
                                                       temp_hash[:from] = val
                                              puts "# from is #{val}"         }  
          opts.on("-l","--list VAL", String) {|val|  
                                              temp_hash[:list] = val
                                             puts "# list is #{val}"         }
          opts.on("-s","--subject VAL", String) {|val|  
                                                  temp_hash[:subject] = val
                                                 puts "# subject is #{val}"         }                                                                                      
       opts.on("-d","--debug", "turn on debug") { |val| temp_hash[:debug ] = true              }     
       opts.on("-k","--key VAL", String) { |val| temp_hash[:key ] = val  
                    puts "# mad mimi api key #{temp_hash[:key]}"            }                        
       opts.on_tail("-H","--help", "get help message") { |val| temp_hash[:help ] = true    
                                          puts opts          }
                                                                                                              
       opts.parse(params)
                     # puts " in HTTP #{hostname} port #{port} url: #{url}"
      
      return temp_hash

     end # parse options
       def self.show_usage_exit(usage)
         # usage=usage.gsub(/^\s*#/,'')
          puts usage
          exit   
        end
  end #class
  # help build xml commands from messages
  
 
  end  #module
  
 