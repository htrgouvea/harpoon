package Scraper::Collector;

use strict;
use warnings;
use WWW::Mechanize;
use Mojo::Util qw( url_escape);

sub new {
    my ($self, $string, $filter) = @_;

    my $browser_agent = WWW::Mechanize -> new();
    my %seen_urls = ();
    my @collected_urls = ();

    my $query_string = url_escape($filter =~ s/\$string/$string/r);

    for (my $page = 0; $page <= 5; $page++) {
        my $url = "http://www.bing.com/search?q=" . $query_string . "&first=" . $page . "0";
                        
        $browser_agent -> get($url);
        my @links = $browser_agent -> links();
                        
        foreach my $link (@links) {
            $url = $link -> url();
            if ($seen_urls{$url}++) {
                next;
            }

            if ($url =~ m/^https?/ && $url !~ m/bing|live|microsoft|msn/) {
                push @collected_urls, $url;
            }
        }
    }

    return @collected_urls;
}

1;
