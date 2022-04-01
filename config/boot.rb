# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# make default  - server is listening on all interfaces (0.0.0.0)
require 'rubygems'

ENV['PORT'] = '3000'
ENV['HOST'] = '0.0.0.0'
