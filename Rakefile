# frozen_string_literal: true

# Gem Spec
require "bundler/gem_tasks"
RUBY_RQRR_SPEC = Bundler.load_gemspec("ruby_rqrr.gemspec")

# Packaging
require "rubygems/package_task"
gem_path = Gem::PackageTask.new(RUBY_RQRR_SPEC).define
desc "Package the Ruby gem"
task "package" => [gem_path]
