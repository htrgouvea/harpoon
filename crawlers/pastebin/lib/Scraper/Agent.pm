package Scraper::Agent;

our $VERSION = '0.01';

use strict;
use warnings;
use JSON;
use LWP::UserAgent;

use constant HTTP_OK => 200;

sub new {
    my ($self, $paste_key, $company_id, $keyword, $filters) = @_;

    my $endpoint  = "http://scrape.pastebin.com/api_scrape_item.php?i=$paste_key";
    my $user_agent = LWP::UserAgent -> new();
    my $response   = $user_agent -> get($endpoint);
    my $status_code  = $response -> code();

    my @filter_rules = split m{ \s / \s }msx, $filters;

    if ($status_code == HTTP_OK) {
        my $data = uc $response -> content();

        $keyword = uc $keyword;
        my $keyword_pattern = quotemeta $keyword;
        my @filter_patterns = map { quotemeta } @filter_rules;

        if (
            ($data =~ m/$keyword_pattern/msx)
            && (0 < grep { $data =~ m/$_/imsx } @filter_patterns)
        ) {
            return $data;
        }
    }

    return q{false};
}

1;
