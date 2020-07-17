source "https://rubygems.org"

gem 'digest-crc', '0.5.1'
gem "fastlane"
gem 'xcov', :git => "https://github.com/mininny/xcov.git"
gem 'fastlane-plugin-test_center'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pl uginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
