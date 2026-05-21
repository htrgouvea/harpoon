package Harpoon::API::Controller::Rule;

our $VERSION = '0.01';

use strict;
use warnings;

use Mojo::Base 'Harpoon::API::Controller::Base', -signatures;
use English qw(-no_match_vars);

sub list ($self) {
    my $service = $self -> stash('service');
    my $pagination = $self -> pagination_metadata;

    my $rules;
    my $total;
    eval {
        $rules = $service -> get_all(
            $pagination->{limit},
            $pagination->{offset}
        );
        if ($pagination->{has_pagination}) {
            $total = $service -> get_count();
        }
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error fetching rules: $error");
        return $self -> json_internal_error;
    };

    return $self -> render_collection($rules, $pagination, $total);
}

sub show ($self) {
    my $service = $self -> stash('service');
    my $id = $self -> param('id');

    my $rule;
    eval {
        $rule = $service -> get_by_id($id);
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error fetching rule: $error");
        return $self -> json_internal_error;
    };

    if (!$rule) {
        return $self -> json_not_found('Rule not found');
    }

    return $self -> render(status => 200, json => $rule);
}

sub create ($self) {
    my $service = $self -> stash('service');
    my $payload = $self -> req -> json;

    if (ref $payload ne 'HASH') {
        $payload = {};
    }

    if (
        !$payload->{id_company}
        || !$payload->{string}
        || !$payload->{filter}
        || !$payload->{score}
        || !$payload->{description}
        || !defined $payload->{status}
    ) {
        return $self -> json_bad_request(
            'Missing required fields: id_company, string, filter, score, description, status'
        );
    }

    my $rule;
    eval {
        $rule = $service -> create(
            {
                id_company => $payload->{id_company},
                string => $payload->{string},
                filter => $payload->{filter},
                score => $payload->{score},
                description => $payload->{description},
                status => $payload->{status}
            }
        );
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error creating rule: $error");
        return $self -> json_internal_error;
    };

    return $self -> render(status => 201, json => $rule);
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
        || !$payload->{string}
        || !$payload->{filter}
        || !$payload->{score}
        || !$payload->{description}
        || !defined $payload->{status}
    ) {
        return $self -> json_bad_request(
            'Missing required fields: id_company, string, filter, score, description, status'
        );
    }

    my $rule;
    eval {
        $rule = $service -> update(
            $id,
            {
                id_company => $payload->{id_company},
                string => $payload->{string},
                filter => $payload->{filter},
                score => $payload->{score},
                description => $payload->{description},
                status => $payload->{status}
            }
        );
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error updating rule: $error");
        return $self -> json_internal_error;
    };

    if (!$rule) {
        return $self -> json_not_found('Rule not found');
    }

    return $self -> render(status => 200, json => $rule);
}

sub remove ($self) {
    my $service = $self -> stash('service');
    my $id = $self -> param('id');

    my $rule;
    eval {
        $rule = $service -> remove($id);
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error deleting rule: $error");
        return $self -> json_internal_error;
    };

    if (!$rule) {
        return $self -> json_not_found('Rule not found');
    }

    return $self -> render(
        status => 200,
        json => {
            message => 'Rule deleted successfully',
            rule => $rule
        }
    );
}

1;
