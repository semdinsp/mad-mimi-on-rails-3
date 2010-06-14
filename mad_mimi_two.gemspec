# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mad_mimi_two}
  s.version = "0.5.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["scott sproule"]
  s.date = %q{2010-05-26}
  s.description = %q{Using Mad Mimi on rails 3.  All of the elegant portions of the code are based on the original http://github.com/redsquirrel/mad_mimi_mailer by ethangunderson. (MadMimiTwo also runs in Rails 2)

All of the terrible stuff is by me.  Apologies for taking an elegant solution and just crafting something that works.}
  s.email = ["scott.sproule@ficonab.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt"]
  s.executables = ["send_mimi.rb"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "lib/mad_mimi_two.rb", "lib/mad_mimi_two/mad_mimi_mailer.rb", "lib/mad_mimi_two/mad_mimi_message.rb", "lib/mad_mimi_two/support.rb", "script/console", "script/destroy", "script/generate", "test/test_helper.rb", "test/test_mad_mimi_two.rb"]
  s.homepage = %q{http://github.com/semdinsp/mad_mimi_two}
  s.post_install_message = %q{For more information on mad_mimi_two, see 
  http://github.com/semdinsp/mad_mimi_two}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{mad_mimi_two}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Using Mad Mimi on rails 3}
  s.test_files = ["test/test_helper.rb", "test/test_mad_mimi_two.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rubyforge>, [">= 2.0.3"])
      s.add_development_dependency(%q<hoe>, [">= 2.6.0"])
    else
      s.add_dependency(%q<rubyforge>, [">= 2.0.3"])
      s.add_dependency(%q<hoe>, [">= 2.6.0"])
    end
  else
    s.add_dependency(%q<rubyforge>, [">= 2.0.3"])
    s.add_dependency(%q<hoe>, [">= 2.6.0"])
  end
end
