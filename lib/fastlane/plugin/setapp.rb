require 'fastlane/plugin/setapp/version'

module Fastlane
  module Setapp
    def self.all_classes
      Dir[File.expand_path('**/{actions,helper}/*.rb', File.dirname(__FILE__))]
    end
  end
end

Fastlane::Setapp.all_classes.each do |current|
  require current
end
