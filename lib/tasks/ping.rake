require 'net/http'

namespace :ping do
  desc "Ping our heroku dyno every 10, 60 or 3600 min"
  task :start do


    if ENV['URL']
      puts "Sending ping"

      uri = URI(ENV['URL'])
      x = Net::HTTP.get_response(uri)

      puts x
      puts "success..."
    end
  end
end
