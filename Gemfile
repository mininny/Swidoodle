source "https://rubygems.org"

gem 'digest-crc', '0.5.1'
gem "fastlane"
gem 'xcov', git: "https://github.com/mininny/xcov.git", branch: "feature/mininny/show-average-coverage-in-log"
gem 'fastlane-plugin-test_center', '3.13.0'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
