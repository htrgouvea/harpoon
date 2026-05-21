package Harpoon::API::Controller::History;

our $VERSION = '0.01';

use strict;
use warnings;

use Mojo::Base 'Harpoon::API::Controller::Base', -signatures;
use English qw(-no_match_vars);

sub list ($self) {
    my $service = $self -> stash('service');
    my $pagination = $self -> pagination_metadata;

    my $history;
    my $total;
    eval {
        $history = $service -> get_all(
            $pagination->{limit},
            $pagination->{offset}
        );
        $total = $service -> get_count() if $pagination->{has_pagination};
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error fetching history records: $error");
        return $self -> json_internal_error;
    };

    return $self -> render_collection($history, $pagination, $total);
}

sub show ($self) {
    my $service = $self -> stash('service');
    my $id = $self -> param('id');

    my $history_record;
    eval {
        $history_record = $service -> get_by_id($id);
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error fetching history record: $error");
        return $self -> json_internal_error;
    };

    if (!$history_record) {
        return $self -> json_not_found('History record not found');
    }

    return $self -> render(status => 200, json => $history_record);
}

sub create ($self) {
    my $service = $self -> stash('service');
    my $payload = $self -> req -> json;

    if (ref $payload ne 'HASH') {
        $payload = {};
    }

    if (!$payload->{id_company} || !defined $payload->{status}) {
        return $self -> json_bad_request('Missing required fields: id_company, status');
    }

    my $history_record;
    eval {
        $history_record = $service -> create(
            {
                id_company => $payload->{id_company},
                source => $payload->{source},
                status => $payload->{status}
            }
        );
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error creating history record: $error");
        return $self -> json_internal_error;
    };

    return $self -> render(status => 201, json => $history_record);
}

sub update ($self) {
    my $service = $self -> stash('service');
    my $id = $self -> param('id');
    my $payload = $self -> req -> json;

    if (ref $payload ne 'HASH') {
        $payload = {};
    }

    if (!$payload->{id_company} || !defined $payload->{status}) {
        return $self -> json_bad_request('Missing required fields: id_company, status');
    }

    my $history_record;
    eval {
        $history_record = $service -> update(
            $id,
            {
                id_company => $payload->{id_company},
                source => $payload->{source},
                datetime => $payload->{datetime},
                status => $payload->{status}
            }
        );
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error updating history record: $error");
        return $self -> json_internal_error;
    };

    if (!$history_record) {
        return $self -> json_not_found('History record not found');
    }

    return $self -> render(status => 200, json => $history_record);
}

sub remove ($self) {
    my $service = $self -> stash('service');
    my $id = $self -> param('id');

    my $history_record;
    eval {
        $history_record = $service -> remove($id);
        1;
    } or do {
        my $error = $EVAL_ERROR;
        $self -> app -> log -> error("Error deleting history record: $error");
        return $self -> json_internal_error;
    };

    if (!$history_record) {
        return $self -> json_not_found('History record not found');
    }

    return $self -> render(
        status => 200,
        json => {
            message => 'History record deleted successfully',
            history => $history_record
        }
    );
}

1;
