#!file:/usr/local/lib/ruby/gems/1.8/gems/appengine-jruby-jars-0.0.5/lib/appengine-jruby-0.0.5.jar!/META-INF/jruby.home/bin/jruby
#
# This file was generated by RubyGems.
#
# The application 'json_pure' is installed as part of a gem, and
# this file is here to facilitate running it.
#

require 'rubygems'

version = ">= 0"

if ARGV.first =~ /^_(.*)_$/ and Gem::Version.correct? $1 then
  version = $1
  ARGV.shift
end

gem 'json_pure', version
load Gem.bin_path('json_pure', 'prettify_json.rb', version)
