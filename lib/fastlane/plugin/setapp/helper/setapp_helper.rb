require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?(:UI)

  module Helper
    class SetappHelper
      def self.show_message
        UI.message("Hello from the setapp plugin helper!")
      end
    end
  end
end
