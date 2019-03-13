use strict;
use Config::Properties;

# reading...
my $config_file = 'config/server.properties'

if ($ENV{'CONFIG_FILE'}) {
  $config_file = $ENV{'CONFIG_FILE'}
}
open my $fh, '<', $config_file
  or die "unable to default open configuration file";
 
my $properties = Config::Properties->new();
$properties->load($fh);

$value = $properties->getProperty($key);

if ($ENV{'BROKER_ID'}) {
  $properties->setProperty('broker.id', $ENV{'BROKER_ID'})
}

if ($ENV{'LOG_DIRS'}) {
  $properties->setProperty('log.dirs', $ENV{'LOG_DIRS'})
}

if ($ENV{'ZK_HOSTS'}) {
  $properties->setProperty('zookeeper.connect', $ENV{'ZK_HOSTS'})
}

# saving...
open my $fh, '>', 'server.properties'
  or die "unable to open configuration file for writing";
 
$properties->store($fh);
