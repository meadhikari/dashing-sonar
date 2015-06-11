require 'dashing'
require 'sinatra/cross_origin'

configure do
  set :auth_token, 'YOUR_AUTH_TOKEN'
  enable :cross_origin
  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end
end
Sinatra::Application.settings.history.clear


map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
