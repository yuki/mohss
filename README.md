# My own Home Security System

This is a personal project to make a Home Security System with a Rapsberry Pi.

The first reason to do it is to learn how Rapsberry's GPIO works. The second
one is to make a personal project which mix hardware and software.

Probably I will replicate some code in different languages like Ruby, Python
and Perl until I decide in which one to code all (or maybe I'll use all of them)

## What you need
This project is made for a Raspberry, so you need one. At this moment Mohss send
tweets, so you need an internet connection (I use a wifi usb dongle), so you can
use a Model A with a wifi usb or a Model B with ethernet.

I use a switch/sensor to know if the door is open or not.

See mohss.png to know how to recreate the circuit:

<img src="https://raw.github.com/yuki/mohss/master/mohss.png" width="400" />

GREEN and RED are one RGB led!! The orange one is a normal led.


## INSTALL
This project has been tested using Ruby 2.1, and few gems are required. To install them you'll need gcc
compiler and ruby-dev libraries

    apt-get install gcc ruby ruby-dev
    gem install pi_piper
    gem install twitter

I think you don't need anymore.

You need to create a **config.yml** file with some needed configuration parameters
(use **config_example.yml** as an example).
After that, I execute mohss in a "screen" session to debug it.

    ./mohss.rb

Or you can add it to the root's crontab to execute it after a reboot (it's need
root permissions for GPIO):

    @reboot cd /root/mohss && ./mohss.rb >> /var/log/mohss.log


## TODO
This is a very first primary alpha non-production just-for-fun project and
there are a lot of things to do. If you have a feature request contact me.

For other, see TODO file

## License
Copyright (c) 2013, [Ruben Gomez](https://github.com/yuki) under
GNU General Public License v3.0:

http://www.gnu.org/licenses/gpl-3.0.html

I’m not responsible for any harm the code or the circuit may cause.


## Thanks
Special thanks to the **Raspberry Pi Foundation**, **www.circuitlab.com** and all the Free Software developers.
