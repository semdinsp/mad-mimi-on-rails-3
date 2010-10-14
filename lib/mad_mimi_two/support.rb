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
       opts.on("-H","--help", "get help message") { |val| temp_hash[:help ] = true              }                                        
                                       
       opts.parse(params)
                     # puts " in HTTP #{hostname} port #{port} url: #{url}"
      
      return temp_hash

     end # parse options
  end #class
  # help build xml commands from messages
 
  end  #module
  
  def RDoc.usage_no_exit(*args)
      # main_program_file = caller[1].sub(/:\d+$/, '')
        main_program_file = caller[1].split(':')[0]
      #puts "main program is #{main_program_file}"
     # puts " caller is #{caller.inspect}"
      comment = File.open(main_program_file) do |file|
        find_comment(file)
      end

      comment = comment.gsub(/^\s*#/, '')

      markup = SM::SimpleMarkup.new
      flow_convertor = SM::ToFlow.new

      flow = markup.convert(comment, flow_convertor)

      format = "plain"

      unless args.empty?
        flow = extract_sections(flow, args)
      end

      options = RI::Options.instance
      if args = ENV["RI"]
        options.parse(args.split)
      end
      formatter = options.formatter.new(options, "")
      formatter.display_flow(flow)
    end
