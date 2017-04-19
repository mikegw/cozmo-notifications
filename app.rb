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
  body notification.to_json
end

post '/api/v2/transactions/create_from_charge' do
  charge = request.POST.to_hash
  notification = {
    id: SecureRandom.hex,
    charge: charge
  }
  notifications << notification
  status 201
  body notification.to_json
end

delete '/:id' do |id|
  notification = notifications.find { |notification| notification['id'] == id }
  halt 404 unless notification
  notifications.delete(notification)
  status 200
  body notification.to_json
end
