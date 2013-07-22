# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "devise_ichain_authenticatable/version"

Gem::Specification.new do |s|
  s.name     = 'devise_ichain_authenticatable'
  s.version  = DeviseIchainAuthenticatable::VERSION.dup
  s.platform = Gem::Platform::RUBY
  s.summary  = 'Devise extension to allow authentication via iChain'
  s.email = 'ancor@suse.de'
  s.homepage = 'https://github.com/openSUSE/devise_ichain_authenticatable'
  s.description = s.summary
  s.authors = ['Ancor González Sosa']
  s.license = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency(%q<devise>, ['>= 2.2'])
end
