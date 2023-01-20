require 'fastlane'
require_relative '../helper/setapp_helper'

module Fastlane
  module Actions
    class UploadSetappBuildAction < Action
      def self.run(params)
        api_token = params[:api_token]
        build_path = params[:build_path]
        release_notes = params[:release_notes]
        version_status = params[:version_status]
        release_on_approval = params[:release_on_approval]
        file_dir = File.dirname(__FILE__)
        UI.user_error!("Available options for version_status: [draft, review].") unless ['draft', 'review'].include?(version_status)
        UI.message("The build at path #{build_path} will be uploaded to Setapp")
        exit_code = system("bash #{file_dir}/../helper/setapp_build_uploader.sh --token #{api_token} --path #{build_path} --notes #{release_notes} --status #{version_status} --release-on-approval #{release_on_approval}")
        UI.user_error!("Uploading error occured. Try again.") if exit_code != true
      end

      def self.description
        "Upload new build to Setapp"
      end

      def self.authors
        ["Setapp Limited"]
      end

      def self.return_value
      end

      def self.details
        [
          "If you chose the `draft` status, Setapp uploads the new build and saves it as a draft.",
          "If you chose the `review`` status, Setapp sends the build for a review.",
          "Read more information about app statuses in our documentation: https://docs.setapp.com/docs/checking-application-statuses"
        ].join("\n")
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :api_token,
            env_name: "SETAPP_API_TOKEN",
            description: "Your Setapp API token",
            optional: false,
            sensitive: true,
            type: String
          ),
          FastlaneCore::ConfigItem.new(
            key: :build_path,
            env_name: "SETAPP_BUILD_PATH",
            description: "Path to an archive with a new bundle version",
            optional: false,
            type: String
          ),
          FastlaneCore::ConfigItem.new(
            key: :release_notes,
            env_name: "SETAPP_RELEASE_NOTES",
            description: "Release notes for a new version. Add them as a plain text or as a path to file with text",
            optional: false,
            type: String
          ),
          FastlaneCore::ConfigItem.new(
            key: :version_status,
            env_name: "SETAPP_VERSION_STATUS",
            description: "Select status for the uploaded build. Available options: `draft`, `review`",
            optional: false,
            type: String
          ),
          FastlaneCore::ConfigItem.new(
            key: :release_on_approval,
            env_name: "SETAPP_RELEASE_ON_APPROVAL",
            description: "Indicate whether Setapp must release new version automatically after review. Available options: `true`, `false`",
            optional: false,
            type: Boolean
          )
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
