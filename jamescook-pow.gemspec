# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in rakefile.rb, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{jamescook-pow}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Cook"]
  s.date = %q{2009-11-20}
  s.description = %q{Ruby 'puts' with shell colors.}
  s.email = %q{jamecook@gmail.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    ".gitignore",
     "README",
     "jamescook-pow.gemspec",
     "lib/pow.rb",
     "pow.rb",
     "rakefile.rb",
     "test/pow_test.rb"
  ]
  s.homepage = %q{http://github.com/jamescook/pow}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{puts with colors}
  s.test_files = [
    "test/pow_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

