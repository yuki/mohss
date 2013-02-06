#!/usr/bin/perl
use strict;
use Net::Twitter::Lite;

print $ARGV[0];
#my $nt = Net::Twitter::Lite->new(
#    username => "yuki_testing",
#    password => "pass"
#);
#
#my $nt = Net::Twitter::Lite->new(
#    consumer_key        => "1",
#    consumer_secret     => "2",
#    access_token        => "3",
#    access_token_secret => "4",
#);
#
##my $result =  $nt->update('Hello, world!');
##my @result = $nt->direct_messages;
##print @result[0];
##my $result = $nt->new_direct_message("rugoli","hey youuuuuu");
##print $result;
#
#unless ( defined $result ) {
#    printf "error updating status: %s\n",
#    $nt->get_error->{error};
#    exit 1;
#}
#
##eval {
##    my $statuses = $nt->friends_timeline({ since_id => $high_water, count => 100 });
##    for my $status ( @$statuses ) {
##        print "$status->{created_at} <$status->{user}{screen_name}> $status->{text}\n";
##    }
##};
##warn "$@\n" if $@;
