package Scraper::Collector;

use strict;
use warnings;
use WWW::Mechanize;

sub new {
    my ($self, $domain) = @_;

    my $mech = WWW::Mechanize -> new();
    my %seen = ();
    my @urls = ();

    my @dorks = (
        "related:$domain",
        "site:$domain intitle:index.of",
        "site:$domain intext:(password | passcode | senha | login | username | userid | user)",
        "site:$domain intext:(restrito | confidencial | interno | private | restricted | internal)",
        "site:$domain filetype:(pdf | txt | docx | sql | csv | xlsx)"
    );

    foreach my $dork (@dorks) {
        for (my $page = 0; $page <= 15; $page++) {
            my $url = "http://www.bing.com/search?q=" . $dork . "&first=" . $page . "0";
                        
            $mech -> get($url);
            my @links = $mech -> links();
                        
            foreach my $link (@links) {
                $url = $link -> url();
                next if $seen{$url}++;

                if ($url =~ m/^https?/ && $url !~ m/bing|live|microsoft|msn/) {
                    push @urls, $url;
                }
            }
        }
    }

    return @urls;
}

1;