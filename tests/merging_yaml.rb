#!/usr/bin/ruby

require 'yaml'
cfg = YAML::load( File.open('config_example.yml'))
cfg.merge!(YAML::load( File.open('config.yml')  ))

puts cfg.inspect
