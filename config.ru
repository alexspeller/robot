require 'appengine-rack'

AppEngine::Rack.configure_app(
    :application => 'naturehackday',
    :version => 1)

require 'robot'
run Sinatra::Application
