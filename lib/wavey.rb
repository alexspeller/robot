require 'rubygems'
require 'set'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Wavey
  VERSION = '0.0.1'
end

require "wavey/mixins/data_format"

require "wavey/models/annotation"
require "wavey/models/blip"
require "wavey/models/context"
require "wavey/models/document"
require "wavey/models/event"
require "wavey/models/operation"
require "wavey/models/robot"
require "wavey/models/wave"
require "wavey/models/wavelet"

require "wavey/ops/blip_ops"