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
        $dbi -> create_model('bing_alert');

        my @rules = Entities::Rules -> new();

        foreach my $value (keys @rules) {
            my $domain    = $rules[$value] -> {domain};
            my @collector = Scraper::Collector -> new($domain);
            
            foreach my $url (@collector) {
                my $md5_hash = md5_hex($url);
                my $query = eval {$dbi -> model('bing_alert') -> select(['REF'], where => {REF => $md5_hash}) -> fetch -> [0]} || 1;

                if ($query eq "1") {
                    my $query = $dbi -> model('bing_alert') -> insert ({
                        ID_COMPANY => $rules[$value] -> {idCompany},
                        URL => $url,
                        STATUS => "0",
                        NOTIFICATION => "0",
                        REF => $md5_hash
                    });
                }
            }
        }
    }
}   

main();
exit;
