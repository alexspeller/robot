require 'appengine-rack'

AppEngine::Rack.configure_app(
    :application => 'naturehackday',
    :version => 1)
$LOAD_PATH << 'lib'
require 'robot'
run Sinatra::Application
