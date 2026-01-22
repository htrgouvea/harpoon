package Entities::Connector;

use strict;
use warnings;
use DBIx::Custom;
use Config::Simple;

sub new {
    my $config   = Config::Simple -> new('./env/database.conf');

    my $hostname = $config -> param('db_hostname');
    my $username = $config -> param('db_username');
    my $password = $config -> param('db_password');
    my $database = $config -> param('db_database');

    my $database_handle = DBIx::Custom -> connect("DBI:mysql:$database;host=$hostname", $username, $password);

    return $database_handle;
}

1;
