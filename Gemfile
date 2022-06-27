# frozen_string_literal: true

source 'http://rubygems.org'

#-------------------- Applications Gems - Put here apllications gems -----------

# IMPORTANTE [TODO] - HOJE O RAILS/PUMA SERVER OS ASSETS DEIXANDO A PARADA MAIS LENTA. MUDAR ISSO PARA O NGIX DO DOKKU

#-------------------- Base Gems - Updated libs 03/2022 -------------------------
# command to update gems -> docker-compose run app bundle install

ruby '3.1.1'
# Rails framework
gem 'rails', '7.0.2.3'
# New way to import jS 
gem 'importmap-rails', '1.0.3'
# server assets like images
gem 'sprockets-rails', '3.4.2', :require => 'sprockets/railtie'
# process SCSS files
gem "sassc-rails", '2.1.2'
# Upgrading from Rails UJS / Turbolinks to Turbo
gem 'turbo-rails', '1.0.1'
# main authorization lib
gem 'devise', '4.8.1'
# Pundit provides a set of helpers which guide you in leveraging regular Ruby classes and object oriented design patterns to build a simple, robust and scalable authorization system.
gem 'pundit', '2.2.0'
# A simple ActiveRecord mixin to add conventions for flagging records as discarded.
gem 'discard', '1.2.1'
# Use postgres
gem 'pg', '1.3.3'
# Pagination lig
gem 'will_paginate', '3.3.1'
# This is a JSON implementation as a Ruby extension in C.
gem 'json', '2.6.1'
#ActiveModel::Serializers allows you to generate your JSON in an object-oriented and convention-driven manner.
gem 'active_model_serializers', '0.10.13'
# SDoc is an HTML template built on top of the RDoc documentation generator for Ruby code. COMMAND: sdoc projectdir
gem 'sdoc', '2.3.1', group: :doc
# An ActiveRecord plugin for managing lists.
gem 'acts_as_list', '1.0.4'
#High-level wrapper for processing images for the web with ImageMagick or libvips.
gem 'image_processing', '1.12.2'
#Multi-tanancy gem acts_as_tenant
gem 'acts_as_tenant', '0.5.1'
#A Ruby client that tries to match Redis' API one-to-one, while still providing an idiomatic interface
gem 'redis', '4.6.0'
#Simple, efficient background processing for Ruby.
gem 'sidekiq', '6.4.1'
# To Fix mimemagic problem
gem 'mimemagic', '0.4.3'
# Great Ruby debugging companion: pretty print Ruby objects to visualize their structure.
gem 'awesome_print', '1.9.2'
#A fast, safe and extensible Markdown to (X)HTML parser
gem 'redcarpet', '3.5.1'
#--------------------------------------------------------------------------------


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '11.1.3'
  # factory_bot provides a framework and DSL for defining and using factories - less error-prone, more explicit, and all-around easier to work with than fixtures.
  gem 'factory_bot_rails', '6.2.0'
  # Faker, a port of Data::Faker from Perl, is used to easily generate fake data: names, addresses, phone numbers, etc.
  gem 'faker', '2.19.0'
end

group :test do
  # SimpleCov is a code coverage analysis tool for Ruby.
  gem 'simplecov', '0.21.2', :require => false, :group => :test
  # testing framework for Rails
  gem 'rspec-rails', '5.1.0'
  # Shoulda Matchers provides RSpec- and Minitest-compatible one-liners that test common Rails functionality. These tests would otherwise be much longer, more complex, and error-prone.
  gem 'shoulda-matchers', '5.1.0'
  # A set of RSpec matchers for testing Pundit authorisation policies. The matcher syntax was inspired by this excellent blog post from Thunderbolt Labs.
  gem 'pundit-matchers', '1.7.0'
  # Capybara is an integration testing tool for rack based web applications. It simulates how a user would interact with a website
  gem 'capybara', '3.37.1'
  # Adds realtime console.log output to Capybara + Selenium + Chromedriver
  # fork from original project to avoid deprecating warnning
  gem 'capybara-chromedriver-logger', git: 'https://github.com/Proposito-Digital/capybara-chromedriver-logger'
  # WebDriver is a tool for writing automated tests of websites. It aims to mimic the behaviour of a real user, and as such interacts with the HTML of the application.
  gem 'selenium-webdriver', '4.3.0'
  # Strategies for cleaning databases. Can be used to ensure a clean slate for testing.
  gem 'database_cleaner', '2.0.1'
end

group :development do
  # to degubar
  # gem 'meta_request'
  # required to solargraph - Modern concurrency tools
  gem 'concurrent-ruby'
  # auto complete ruby comand with documentation.
  gem 'solargraph'
  # code quality analizer.
  gem 'rubocop'
  # Ruby on Rails 3/4/5 model and controller UML class diagram generator. Originally based on the 'railroad' plugin and contributions of many others. (`brew install graphviz` before use!)
  gem 'railroady'
  # Better Errors replaces the standard Rails error page with a much better and more useful error page. It is also usable outside of Rails in any Rack app as Rack middleware.
  gem "better_errors"
  # Provides the Binding#of_caller method. Using binding_of_caller we can grab bindings from higher up the call stack and evaluate code in that context. Allows access to bindings arbitrarily far up the call stack, not limited to just the immediate caller. Recommended for use only in debugging situations. Do not use this in production apps.
  gem "binding_of_caller"
end

group :production, :teste do
  # production web server
  gem 'puma', '5.6.2'
end
