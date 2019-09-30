require 'json'
require 'dotenv/load'

File.open('config.json', 'w') do |file|
  hash = {
    client_id: ENV['GD_CLIENT_ID'],
    client_secret: ENV['GD_CLIENT_SECRET'],
    scope: ["https://www.googleapis.com/auth/drive", "https://spreadsheets.google.com/feeds/"],
    refresh_token: ENV['GD_REFRESH_TOKEN']
  }
  JSON.dump(hash, file)
end
