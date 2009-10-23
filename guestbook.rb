# Copyright 2009 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'net/http'

Net::HTTP

# Configure DataMapper to use the App Engine datastore 
DataMapper.setup(:default, "appengine://auto")

# Create your model class
class Shout
  include DataMapper::Resource
  
  property :id, Serial
  property :message, Text
end

# Make sure our template can use <%=h
helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

get '/' do
  # Just list all the shouts
  @shouts = Shout.all
  erb :index
end


post '/' do
  # Create a new shout and redirect back to the list.
  shout = Shout.create(:message => params[:message])
  redirect '/'
end


get '/_wave/capabilities.xml' do
  <<EOF
<w:robot xmlns:w="http://wave.google.com/extensions/robots/1.0">
  <w:capabilities>
    <w:capability name="DOCUMENT_CHANGED"/>
  </w:capabilities>
  <w:profile name="galculator" imageurl="http://galculator.appspot.com/image.png" profileurl="http://galculator.appspot.com/_wave/robot/profile"/>
</w:robot>
EOF
end

get '/_wave/robot/jsonrpc' do

end
