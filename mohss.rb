#!/usr/bin/ruby

###
# My Security System made with a Raspberry
# 
# version = 0.0.5a
###

require 'yaml'
require 'twitter'
require 'pi_piper'
require 'SocketIO'
require 'json'
include PiPiper

ACTIVATED = 15 # green cable
DOOR = 2 # yellow cable
ALARM = 14 # red cable
OFF = 4 # blue IGNORE IT at this moment :p
MESSENGER_SOCKETIO_ADDRESS="http://rugoli.no-ip.org:8000"
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
  puts "#{Time.now()} tweeting: #{msg}"
  #Twitter.create_direct_message(receiver,msg)
end

def contact_node(name,args)
    SocketIO.connect(MESSENGER_SOCKETIO_ADDRESS, sync: true) do
        after_start do
          emit(name, args)
          disconnect
        end
    end
end


if __FILE__ == $PROGRAM_NAME
  cfg = YAML::load( File.open('config.yml'))
  Twitter::REST::Client.new do |twitcfg|
    twitcfg.consumer_key = cfg["twitter"]["consumer_key"]
    twitcfg.consumer_secret = cfg["twitter"]["consumer_secret"]
    twitcfg.access_token = cfg["twitter"]["oauth_token"]
    twitcfg.access_token_secret = cfg["twitter"]["oauth_token_secret"]
  end
  receiver = cfg["twitter"]["receiver"]

  puts "#{Time.now()} system activated!!"

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
    puts "#{Time.now()} door closed #{activated}"
    send_tweet(receiver, "door closed") if activated
    led_off(ALARM)
    led_on(ACTIVATED)
    contact_node("changes",{ door_status: 'false' }.to_json)
  end

  after :pin => DOOR, :goes => :down do
    puts "#{Time.now()} DOOR OPEN, INTRUSION!"
    send_tweet(receiver, "DOOR OPEN, INTRUSION!") if activated
    led_on(ALARM)
    led_off(ACTIVATED)
    contact_node("changes",{ door_status: 'true' }.to_json)
  end
  #switch off alarm
  led_off(ALARM)
  #led_off(OFF)
  #define DOOR sensor as input
  sensor = def_pin(DOOR,:in)
  #switch on system
  led_on(ACTIVATED)

  client = SocketIO.connect("http://localhost:8000", sync:true) do
    before_start do
      on_event('changes') {
        |data| puts data.first
        puts data.inspect
      }
    end
  end

  PiPiper.wait
end
