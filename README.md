# setapp plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-setapp)

## Getting Started

This project is a [fastlane](https://github.com/fastlane/fastlane) plugin. To get started with fastlane-plugin-setapp, you can either add it globally for all projects, or locally to an individual project.

### Globally

If you install the gem globally, you can run it with any project that is setup for using `fastlane`.

```bash
gem install fastlane-plugin-setapp
```

Add the actions you want to use to your `Fastfile` file and call `fastlane` to run.

### Locally

You can also add the plugin for individual projects. Navigate to your project where `fastlane` is already set up and run the following command:

```bash
bundle exec fastlane add_plugin setapp
```

Fastlane will guide you through the process. It will add a `Pluginfile` where the sentry plugin is listed and also update the `Gemfile` and `Gemfile.lock` to include it as a dependency.

```ruby
# Autogenerated by fastlane
#
# Ensure this file is checked in to source control!

gem 'fastlane-plugin-setapp'
```

Add the actions you want to use to your `Fastfile` file and call `bundle exec fastlane` to run.

## Setapp actions

A subset of actions to upload new builds to Setapp.

### Upload Setapp build

Uploads new version to Setapp and save it as a draft or send to a review process. You can add release notes for new build and specify if a version should be released right after approval.

```ruby
upload_setapp_build(
  automation_token: '...', # Your Setapp Automation token
  build_path: '...', # The path to archive with a new Setapp build
  release_notes: '...', # Text or path to a file that contains release notes for a new version
  version_status: 'review', # Version status. It can be `draft` or `review`
  release_on_approval: true, # Indicates whether Setapp must publish a new version after review
  is_beta: false, # Is beta or stable build
  allow_overwrite: true # Allow to overwrite existing version
)
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
