$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))

require 'simplecov'

# SimpleCov.minimum_coverage 95
SimpleCov.start

# This module is only used to check the environment is currently a testing env
module SpecHelper
end

require 'fastlane'
require 'fastlane/plugin/setapp'

Fastlane.load_actions # load other actions (in case your plugin calls other actions or shared values)
