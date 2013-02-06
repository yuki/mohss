#!/home/yuki/.rvm/rubies/ruby-1.9.2-p290/bin/ruby

require "twitter"

puts "llamando a Twitter"


Twitter.configure do |config|
  config.consumer_key = "1"
  config.consumer_secret = "2"
  config.oauth_token = "3"
  config.oauth_token_secret = "4"
end

#Twitter.update("I'm tweeting with @gem!")
Twitter.direct_message_create("rugoli","hola123")
