#!/usr/bin/perl


use strict;
use Config::YAML;

my $config = Config::YAML->new( config => "config.yml");

print $config["twitter"];
