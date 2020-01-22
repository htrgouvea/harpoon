#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;
use lib "./lib/";
use Entities::Connector;
use Entities::Rules;
use Scraper::Agent;
use Scraper::Collector;

sub main {
    my $dbi = Entities::Connector -> new();

    if ($dbi) {
        $dbi -> create_model('pastebin_alert');
        $dbi -> create_model('pastebin_history');

        my @rules = Entities::Rules -> new();
        my @collector = Scraper::Collector -> new();

        foreach my $key (@collector) {

            my $query = eval {$dbi -> model('pastebin_history') -> select(
                ['REF'], where => {REF => $key}
            ) -> fetch -> [0]} || 1;
            
            print "[+] -> $key\n";

            if ($query eq "1") {
                foreach my $value (keys @rules) {
                    my $agent = Scraper::Agent -> new (
                        $key,
                        $rules[$value] -> {idCompany},
                        $rules[$value] -> {word},
                        $rules[$value] -> {filter}
                    );

                    if ($agent ne "false") {
                        my $query = $dbi -> model('pastebin_alert') -> insert ({
                            ID_COMPANY => $rules[$value] -> {idCompany},
                            CONTENT => $agent,
                            STATUS => "0",
                            NOTIFICATION => "0",
                            REF => $key
                        });
                    }
                }
                
                my $query = $dbi -> model('pastebin_history') -> insert({REF => $key});
            }
        }
    }
}

main();
exit;