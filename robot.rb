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
require 'json/pure'

require 'wavey'

include Wavey::Mixins::DataFormat

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

get '/test' do
   body = %{{"blips":{"map":{"b+mVxsqBYWB":{"lastModifiedTime":1256313401284,"contributors":{"javaClass":"java.util.ArrayList","list":["alexspeller@googlewave.com"]},"waveletId":"googlewave.com!conv+root","waveId":"googlewave.com!w+mVxsqBYWA","parentBlipId":null,"version":24,"creator":"alexspeller@googlewave.com","content":"Thiis a test wae","blipId":"b+mVxsqBYWB","javaClass":"com.google.wave.api.impl.BlipData","annotations":{"javaClass":"java.util.ArrayList","list":[{"range":{"start":-1,"javaClass":"com.google.wave.api.Range","end":16},"name":"conv/title","value":"","javaClass":"com.google.wave.api.Annotation"},{"range":{"start":-1,"javaClass":"com.google.wave.api.Range","end":16},"name":"lang","value":"unknown","javaClass":"com.google.wave.api.Annotation"}]},"elements":{"map":{},"javaClass":"java.util.HashMap"},"childBlipIds":{"javaClass":"java.util.ArrayList","list":[]}}},"javaClass":"java.util.HashMap"},"robotAddress":"naturehackday@appspot.com","events":{"javaClass":"java.util.ArrayList","list":[{"timestamp":1256313401522,"modifiedBy":"alexspeller@googlewave.com","javaClass":"com.google.wave.api.impl.EventData","properties":{"map":{"blipId":"b+mVxsqBYWB"},"javaClass":"java.util.HashMap"},"type":"DOCUMENT_CHANGED"}]},"wavelet":{"lastModifiedTime":1256313401522,"title":"Thiis a test wae","waveletId":"googlewave.com!conv+root","rootBlipId":"b+mVxsqBYWB","javaClass":"com.google.wave.api.impl.WaveletData","dataDocuments":{"map":{},"javaClass":"java.util.HashMap"},"creationTime":1256313389244,"waveId":"googlewave.com!w+mVxsqBYWA","participants":{"javaClass":"java.util.ArrayList","list":["alexspeller@googlewave.com","naturehackday@appspot.com"]},"creator":"alexspeller@googlewave.com","version":25}}}

  do_wave_stuff(body)
end

def do_wave_stuff(json_string)
  context, events = parse_json_body(json_string)
  wavelet = context.wavelets.to_a.first[1]
  # raise [wavelet.root_blip_id, context.blips.inspect].inspect
  blip = context.blips[wavelet.root_blip_id]
  blip.set_text("Only I get to edit the top blip!")
  
  context.to_json
end

post '/_wave/robot/jsonrpc' do
  body = request.env["rack.input"].read

  do_wave_stuff(body)  
  
end
