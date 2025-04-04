# frozen_string_literal: true

require_relative "lib/ruby_rqrr/version"

Gem::Specification.new do |spec|
  spec.name = "ruby_rqrr"
  spec.version = RubyRqrr::VERSION
  spec.authors = ["Shawn Jordan"]
  spec.email = ["shawn.jordan@me.com"]

  spec.summary = "A Ruby Binding for Rust's RQRR'."
  spec.description = "This gem brings in a rust library (RQRR) to detect QR codes in images."
  spec.homepage = "https://github.com/phchun/ruby_rqrr"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"
  spec.required_rubygems_version = ">= 3.3.11"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/phchun/ruby_rqrr"
  spec.metadata["changelog_uri"] = "https://github.com/phchun/ruby_rqrr/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions = ["ext/ruby_rqrr/extconf.rb"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "rb_sys", "~> 0.9.91"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
