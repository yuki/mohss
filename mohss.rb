#!/usr/bin/ruby

###
# My Security System made with a Raspberry
# 
# version = 0.0.1a
###

require 'yaml'
require 'twitter'
require 'pi_piper'
include PiPiper

ACTIVATED = 15 # green cable
DOOR = 2 # yellow cable
ALARM = 14 # red cable
OFF = 4 # blue IGNORE IT at this moment :p
activated = true


# return a pin in the direction especified, default :out
def def_pin (pin,dir=:out)
  return PiPiper::Pin.new(:pin => pin, :direction => dir)
end

# switch an RGB led ON (one of the colours!)
def led_on (pin)
  led = def_pin(pin)
  led.off
end

# switch an RGB led ON (one of the colours!)
def led_off (pin)
  led = def_pin(pin)
  led.on
end

# as it name says, send a tweet
def send_tweet(receiver,msg)
  puts "tweeting: #{msg}"
  Twitter.direct_message_create(receiver,msg)
end


if __FILE__ == $PROGRAM_NAME
  cfg = YAML::load( File.open('config.yml'))
  Twitter.configure do |twitcfg|
    twitcfg.consumer_key = cfg["twitter"]["consumer_key"]
    twitcfg.consumer_secret = cfg["twitter"]["consumer_secret"]
    twitcfg.oauth_token = cfg["twitter"]["oauth_token"]
    twitcfg.oauth_token_secret = cfg["twitter"]["oauth_token_secret"]
  end
  receiver = cfg["twitter"]["receiver"]

  puts "system activated!!"
  
  after :pin => ACTIVATED, :goes => :down do
    unless activated
      led_off(OFF)
    end
  end
  
  after :pin => ACTIVATED, :goes => :high do
    unless activated
      led_on(OFF)
    end
  end
  
  after :pin => DOOR, :goes => :high do
    puts "door closed"
    led_off(ALARM)
    led_on(ACTIVATED)
    send_tweet(receiver, "door closed")
  end
  
  after :pin => DOOR, :goes => :down do
    puts "DOOR OPEN, INTRUSION!"
    led_on(ALARM)
    led_off(ACTIVATED)
    send_tweet(receiver, "DOOR OPEN, INTRUSION!")
  end

  #switch off alarm
  led_off(ALARM)
  #led_off(OFF)
  #define DOOR sensor as input
  sensor = def_pin(DOOR,:in)
  #switch on system
  led_on(ACTIVATED)
  
  PiPiper.wait
end
