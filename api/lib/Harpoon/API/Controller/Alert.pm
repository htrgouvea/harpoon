package Harpoon::API::Controller::Alert;

our $VERSION = '0.01';

use strict;
use warnings;

use Mojo::Base 'Harpoon::API::Controller::Base', -signatures;
use English qw(-no_match_vars);

sub list ($self) {
    my $service = $self -> stash('service');
    my $pagination = $self -> pagination_metadata;

    my $alerts;
    eval {
        $alerts = $service -> get_all(
            $pagination->{limit},
            $pagination->{offset}
        );
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error fetching alerts: $error");
        return $self -> json_internal_error;
    };

    if ($pagination->{has_pagination}) {
        return $self -> render(
            status => 200,
            json => {
                data => $alerts,
                pagination => {
                    page => $pagination->{page},
                    limit => $pagination->{limit},
                    total => scalar @{$alerts}
                }
            }
        );
    }

    return $self -> render(status => 200, json => $alerts);
}

sub show ($self) {
    my $service = $self -> stash('service');
    my $id = $self -> param('id');

    my $alert;
    eval {
        $alert = $service -> get_by_id($id);
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error fetching alert: $error");
        return $self -> json_internal_error;
    };

    if (!$alert) {
        return $self -> json_not_found('Alert not found');
    }

    return $self -> render(status => 200, json => $alert);
}

sub create ($self) {
    my $service = $self -> stash('service');
    my $payload = $self -> req -> json;

    if (ref $payload ne 'HASH') {
        $payload = {};
    }

    if (
        !$payload->{id_company}
        || !defined $payload->{status}
        || !defined $payload->{notification}
        || !$payload->{content}
        || !$payload->{hash}
    ) {
        return $self -> json_bad_request(
            'Missing required fields: id_company, status, notification, content, hash'
        );
    }

    my $alert;
    eval {
        $alert = $service -> create(
            {
                id_company => $payload->{id_company},
                status => $payload->{status},
                notification => $payload->{notification},
                content => $payload->{content},
                hash => $payload->{hash}
            }
        );
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error creating alert: $error");
        return $self -> json_internal_error;
    };

    return $self -> render(status => 201, json => $alert);
}

sub update ($self) {
    my $service = $self -> stash('service');
    my $id = $self -> param('id');
    my $payload = $self -> req -> json;

    if (ref $payload ne 'HASH') {
        $payload = {};
    }

    if (
        !$payload->{id_company}
        || !defined $payload->{status}
        || !defined $payload->{notification}
        || !$payload->{content}
        || !$payload->{hash}
    ) {
        return $self -> json_bad_request(
            'Missing required fields: id_company, status, notification, content, hash'
        );
    }

    my $alert;
    eval {
        $alert = $service -> update(
            $id,
            {
                id_company => $payload->{id_company},
                datetime => $payload->{datetime},
                status => $payload->{status},
                notification => $payload->{notification},
                content => $payload->{content},
                hash => $payload->{hash}
            }
        );
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error updating alert: $error");
        return $self -> json_internal_error;
    };

    if (!$alert) {
        return $self -> json_not_found('Alert not found');
    }

    return $self -> render(status => 200, json => $alert);
}

sub remove ($self) {
    my $service = $self -> stash('service');
    my $id = $self -> param('id');

    my $alert;
    eval {
        $alert = $service -> remove($id);
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error deleting alert: $error");
        return $self -> json_internal_error;
    };

    if (!$alert) {
        return $self -> json_not_found('Alert not found');
    }

    return $self -> render(
        status => 200,
        json => {
            message => 'Alert deleted successfully',
            alert => $alert
        }
    );
}

1;
