package Scraper::Collector;

our $VERSION = '0.01';

use strict;
use warnings;
use WWW::Mechanize;
use Mojo::Util qw( url_escape);

use constant LAST_PAGE => 5;

sub new {
    my ($self, $string, $filter) = @_;

    my $browser_agent = WWW::Mechanize -> new();
    my %seen_urls = ();
    my @collected_urls = ();

    my $query_string = url_escape($filter =~ s/\$string/$string/rmsx);

    foreach my $page (0 .. LAST_PAGE) {
        my $url = q{http://www.bing.com/search?q=} . $query_string . q{&first=} . $page . q{0};

        $browser_agent -> get($url);
        my @links = $browser_agent -> links();

        foreach my $link (@links) {
            $url = $link -> url();
            if ($seen_urls{$url}++) {
                next;
            }

            if ($url =~ m/^https?/msx && $url !~ m/bing|live|microsoft|msn/msx) {
                push @collected_urls, $url;
            }
        }
    }

    return @collected_urls;
}

1;
