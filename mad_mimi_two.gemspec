#From http://railscasts.com/episodes/183-gemcutter-jeweler
#sudo gem install gemcutter
#gem tumble
#gem build mad_mimi_two.gemspec
#gem push mad_mimi_two.gem
#sudo gem install jeweler
#rake --tasks
#rake version:write
#rake version:bump:minor
#rake gemcutter:release
Gem::Specification.new do |s|
  s.name        = "mad_mimi_two"
  s.version     = "0.0.5"
  s.author      = "Scott Sproule"
  s.email       = "scott.sproule@estormtech.com"
  s.homepage    = "http://github.com/semdinsp/mad-mimi-on-rails-3"
  s.summary     = "Use MadMimi with Rails 3"
  s.description = "Update to the original madmimimailer gem to support the new actionmailer of rails3"
  
  s.files        = Dir["{lib,test}/**/*"] + Dir["[A-Z]*"] # + ["init.rb"]
  s.require_path = "lib"
  
  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
end