#!/usr/bin/env perl

package Entities::Connector;

use DBIx::Custom;
use Config::Simple;

sub new {
    my $config   = Config::Simple -> new('config.ini');
    
    my $hostname = $config -> param('db_hostname');
    my $username = $config -> param('db_username');
    my $password = $config -> param('db_password');
    my $database = $config -> param('db_database');

    my $dbi = DBIx::Custom -> connect("DBI:mysql:$database;host=$hostname", $username, $password);
}

1;