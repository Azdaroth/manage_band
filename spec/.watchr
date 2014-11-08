require_relative 'watchr_spec_runner'

watch("spec/(.*/*)_spec.rb") do |match|
  WatchrSpecRunner.new.for_spec_file match[0]
end

watch("lib/(.*/.*).rb") do |match|
  WatchrSpecRunner.new.for_lib_file match[1]
end