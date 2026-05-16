package Harpoon::API::Controller::Company;

our $VERSION = '0.01';

use strict;
use warnings;

use Mojo::Base 'Harpoon::API::Controller::Base', -signatures;
use English qw(-no_match_vars);

sub list ($self) {
    my $service = $self -> stash('service');
    my $pagination = $self -> pagination_metadata;

    my $companies;
    eval {
        $companies = $service -> get_all(
            $pagination->{limit},
            $pagination->{offset}
        );
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error fetching companies: $error");
        return $self -> json_internal_error;
    };

    if ($pagination->{has_pagination}) {
        return $self -> render(
            status => 200,
            json => {
                data => $companies,
                pagination => {
                    page => $pagination->{page},
                    limit => $pagination->{limit},
                    total => scalar @{$companies}
                }
            }
        );
    }

    return $self -> render(status => 200, json => $companies);
}

sub show ($self) {
    my $service = $self -> stash('service');
    my $id = $self -> param('id');

    my $company;
    eval {
        $company = $service -> get_by_id($id);
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error fetching company: $error");
        return $self -> json_internal_error;
    };

    if (!$company) {
        return $self -> json_not_found('Company not found');
    }

    return $self -> render(status => 200, json => $company);
}

sub create ($self) {
    my $service = $self -> stash('service');
    my $payload = $self -> req -> json;

    if (ref $payload ne 'HASH') {
        $payload = {};
    }

    if (!$payload->{name} || !$payload->{email} || !defined $payload->{status}) {
        return $self -> json_bad_request('Missing required fields: name, email, status');
    }

    my $company;
    eval {
        $company = $service -> create(
            {
                name => $payload->{name},
                email => $payload->{email},
                status => $payload->{status}
            }
        );
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error creating company: $error");
        return $self -> json_internal_error;
    };

    return $self -> render(status => 201, json => $company);
}

sub update ($self) {
    my $service = $self -> stash('service');
    my $id = $self -> param('id');
    my $payload = $self -> req -> json;

    if (ref $payload ne 'HASH') {
        $payload = {};
    }

    if (!$payload->{name} || !$payload->{email} || !defined $payload->{status}) {
        return $self -> json_bad_request('Missing required fields: name, email, status');
    }

    my $company;
    eval {
        $company = $service -> update(
            $id,
            {
                name => $payload->{name},
                email => $payload->{email},
                status => $payload->{status}
            }
        );
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error updating company: $error");
        return $self -> json_internal_error;
    };

    if (!$company) {
        return $self -> json_not_found('Company not found');
    }

    return $self -> render(status => 200, json => $company);
}

sub remove ($self) {
    my $service = $self -> stash('service');
    my $id = $self -> param('id');

    my $company;
    eval {
        $company = $service -> remove($id);
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error deleting company: $error");
        return $self -> json_internal_error;
    };

    if (!$company) {
        return $self -> json_not_found('Company not found');
    }

    return $self -> render(
        status => 200,
        json => {
            message => 'Company deleted successfully',
            company => $company
        }
    );
}

1;
