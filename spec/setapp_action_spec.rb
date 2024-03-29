describe Fastlane::Actions::UploadSetappBuildAction do
  describe '#run' do
    it 'Validates version status' do
      expect do
        Fastlane::Actions::UploadSetappBuildAction.run(
          api_key: "bar",
          setapp_build_path: "baz",
          release_notes: "bar",
          version_status: "invalid value",
          release_on_approval: "true"
        )
      end.to raise_error("Available options for version_status: [draft, review].")
    end
  end
end
