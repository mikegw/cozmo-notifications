require 'bundler'
Bundler.require

require 'json'
require 'logger'
require 'securerandom'

notifications = []
LOGGER = Logger.new(STDOUT)

get '/' do
  status 200
  body notifications.to_json
end

post '/' do
  notification = JSON.parse(request.body.read)
  notification['id'] = SecureRandom.hex
  notifications << notification
  status 201
end

delete '/:id' do |id|
  notification = notifications.find { |notification| notification['id'] == id }
  halt 404 unless notification
  notifications.delete(notification)
  status 200
end
