require 'appengine-rack'

AppEngine::Rack.configure_app(
    :application => 'naturehackday',
    :version => 1)

require 'guestbook'
run Sinatra::Application
