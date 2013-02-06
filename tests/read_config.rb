#!/usr/bin/ruby

require 'yaml'
require 'twitter'

cfg = YAML::load( File.open('config.yml'))
Twitter.configure do |twitcfg|
  twitcfg.consumer_key = cfg["twitter"]["consumer_key"]
  twitcfg.consumer_secret = cfg["twitter"]["consumer_secret"]
  twitcfg.oauth_token = cfg["twitter"]["oauth_token"]
  twitcfg.oauth_token_secret = cfg["twitter"]["oauth_token_secret"]
end
#Twitter.direct_message_create("rugoli","hola123")
