# frozen_string_literal: true

require "rb_sys/extensiontask"

RbSys::ExtensionTask.new("ruby_rqrr", RUBY_RQRR_SPEC) do |ext|
  ext.lib_dir = File.join("lib", "ruby_rqrr")
  ext.cross_compile = true
  ext.cross_platform = [
    "x86_64-linux",
    "aarch64-linux",
    "x86_64-darwin",
    "arm64-darwin",
    "x64-mingw-ucrt"
  ]
end
