require 'ruby_fps/pipelines/base'
Dir[File.dirname(__FILE__) + '/pipelines/*'].each do |p| require "ruby_fps/pipelines/#{File.basename(p)}" end
