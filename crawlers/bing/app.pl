#!/usr/bin/env perl

use 5.018;
use strict;
use warnings;
use lib "./lib/";
use Entities::Rules;
use Entities::Connector;
use Scraper::Collector;
use Digest::MD5 qw(md5_hex);

sub main {
    my $dbi = Entities::Connector -> new();

    if ($dbi) {
        $dbi -> create_model('alert');

        my @rules = Entities::Rules -> new();

        foreach my $item (keys @rules) {
            my $string = $rules[$item] -> {string};
            my $filter = $rules[$item] -> {filter};
            
            my @collector = Scraper::Collector -> new($string, $filter);

            foreach my $url (@collector) {
                my $md5_hash = md5_hex($url);
                
                my $query = eval {
                    $dbi -> model('alert') -> select(
                        ['HASH'], where => { HASH => $md5_hash }
                    ) -> fetch -> [0]
                } || 1;

                if (length($query) == 1) {
                    my $query = $dbi -> model('alert') -> insert ({
                        ID_COMPANY => $rules[$item] -> {company},
                        CONTENT => $url,
                        STATUS => 0,
                        NOTIFICATION => 0,
                        HASH => $md5_hash
                    });
                }
            }
        }
    }
}   

main();
exit;