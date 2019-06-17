use strict;
use Config::Properties;

# reading...
my $config_file = 'config/server.properties';

if ($ENV{'CONFIG_FILE'}) {
  $config_file = $ENV{'CONFIG_FILE'};
}
open my $fh, '<', $config_file
  or die "unable to open configuration file";
 
my $properties = Config::Properties->new();
$properties->load($fh);

if ($ENV{'BROKER_ID'}) {
  $properties->setProperty('broker.id', $ENV{'BROKER_ID'});
}

if ($ENV{'ZK_HOSTS'}) {
  $properties->setProperty('zookeeper.connect', $ENV{'ZK_HOSTS'});
}

if ($ENV{'EXTERNAL_PORT_BASE'} && $ENV{'EXTERNAL_HOST'}) {
  my $external_port = int($ENV{'EXTERNAL_PORT_BASE'}) + int($ENV{'BROKER_ID'})
  $properties->setProperty('advertised.listeners', $ENV{'PLAINTEXT://'.$ENV{'EXTERNAL_HOST'}.':'.$external_port});
}
$properties->setProperty('log.dirs', '/data');

# saving...
open my $fh, '>', 'server.properties'
  or die "unable to open configuration file for writing";
 
$properties->store($fh);
