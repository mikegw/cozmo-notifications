require 'bundler'
Bundler.require

require 'json'
require 'logger'

notifications = []
LOGGER = Logger.new(STDOUT)

get '/' do
  status 200
  body notifications.to_json
end

post '/' do
  notification = JSON.parse(request.body.read)
  notifications << notification
  status 201
end
