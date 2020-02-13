package Entities::Connector;

use strict;
use warnings;
use DBIx::Custom;
use Config::Simple;

my $config = Config::Simple -> new('/home/Projects/uranus/workers/email-notify/env/database.conf');

sub DBI {
    my $hostname = $config -> param('db_hostname');
    my $username = $config -> param('db_username');
    my $password = $config -> param('db_password');
    my $database = $config -> param('db_database');

    my $dbi = DBIx::Custom -> connect("DBI:mysql:$database;host=$hostname", $username, $password);
}

1;