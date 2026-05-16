package Harpoon::API::Controller::Base;

our $VERSION = '0.01';

use strict;
use warnings;

use Mojo::Base 'Mojolicious::Controller', -signatures;

use constant DEFAULT_LIMIT => 100;

sub parse_integer ($self, $value) {
    if (!defined $value) {
        return;
    }

    if ($value =~ m/^\s*([+-]?\d+)/msx) {
        return 0 + $1;
    }

    return;
}

sub pagination_metadata ($self) {
    my $page_query = $self -> param('page');
    my $limit_query = $self -> param('limit');

    my $has_pagination = defined $page_query || defined $limit_query;

    my $limit;
    if ($has_pagination) {
        my $parsed_limit = $self -> parse_integer($limit_query);
        $limit = $parsed_limit || DEFAULT_LIMIT;
    }

    my $parsed_page = $self -> parse_integer($page_query);
    my $page = $parsed_page || 0;

    my $offset = $page * ($limit || 0);

    return {
        has_pagination => $has_pagination,
        limit => $limit,
        page => $page,
        offset => $offset
    };
}

sub json_bad_request ($self, $message) {
    return $self -> render(status => 400, json => {error => $message});
}

sub json_not_found ($self, $message) {
    return $self -> render(status => 404, json => {error => $message});
}

sub json_internal_error ($self) {
    return $self -> render(status => 500, json => {error => 'Internal server error'});
}

1;
