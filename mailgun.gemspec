# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Akash Manohar J", "Sean Grove"]
  gem.email         = ["akash@akash.im"]
  gem.description   = %q{Mailgunna library for Ruby}
  gem.summary       = %q{Idiomatic library for using the mailgunna API from within ruby}
  gem.homepage      = "http://github.com/HashNuke/mailgunna"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "mailgunna"
  gem.require_paths = ["lib"]
  gem.version       = "0.8"
  
  gem.add_dependency(%q<rest-client>, [">= 0"])  

  gem.add_development_dependency(%q<rspec>, [">= 2"])
  gem.add_development_dependency(%q<debugger>, [">= 0"])
  gem.add_development_dependency(%q<vcr>, [">= 0"])
end
