# frozen_string_literal: true

require "rake/extensiontask"

Dir.glob("lib/tasks/*.rake").each { |r| load r }

Rake::ExtensionTask.new("sgp4sdp4") do |ext|
  ext.lib_dir = File.join("lib", "sgp4sdp4")
end

Rake::ExtensionTask.new("sgp4") do |ext|
  ext.lib_dir = File.join("lib", "sgp4")
end
