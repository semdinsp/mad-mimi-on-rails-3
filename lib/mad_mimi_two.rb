$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
Dir[File.join(File.dirname(__FILE__), 'mad_mimi_two/**/*.rb')].sort.each { |lib| require lib }

module MadMimiTwo
  VERSION = '0.0.3'
end