package Harpoon::Crawler::DetectionEngine;

our $VERSION = '0.01';

use strict;
use warnings;

sub matches_keyword_and_filters {
    my ($class, $content, $keyword, $filters) = @_;

    return 0 if !defined $content || !defined $keyword || !defined $filters;

    my $normalized_content = uc $content;
    my $normalized_keyword = uc $keyword;
    my @filter_rules = split m{ \s / \s }msx, $filters;

    my $keyword_pattern = quotemeta $normalized_keyword;
    my @filter_patterns = map { quotemeta uc $_ } @filter_rules;

    return 0 if $normalized_content !~ m/$keyword_pattern/msx;

    return 0 == grep { $normalized_content =~ m/$_/msx } @filter_patterns
        ? 0
        : 1;
}

1;
