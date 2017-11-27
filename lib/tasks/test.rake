# frozen_string_literal: true

require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs.push "test"
  t.pattern = "test/**/*_test.rb"
  t.warning = true
  t.verbose = true
end

task default: :test
