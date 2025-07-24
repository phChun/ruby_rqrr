# frozen_string_literal: true

require "bundler/gem_tasks"
require "minitest/test_task"

Minitest::TestTask.create

require "standard/rake"

require "rb_sys/extensiontask"

task build: :compile

GEMSPEC = Gem::Specification.load("ruby_rqrr.gemspec")

RbSys::ExtensionTask.new("ruby_rqrr", GEMSPEC) do |ext|
  ext.lib_dir = "lib/ruby_rqrr"
end

task default: %i[compile test standard]
