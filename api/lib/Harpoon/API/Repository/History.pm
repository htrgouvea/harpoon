package Harpoon::API::Repository::History;

our $VERSION = '0.01';

use strict;
use warnings;

use Mojo::Base -base, -signatures;

has 'pg';

sub find_all ($self, $limit, $offset) {
    my $db = $self -> pg -> db;

    if (!defined $limit) {
        my $results = $db -> query('SELECT * FROM public.history ORDER BY id');
        return $results -> hashes -> to_array;
    }

    my $results = $db -> query(
        'SELECT * FROM public.history ORDER BY id LIMIT ? OFFSET ?',
        $limit,
        $offset
    );

    return $results -> hashes -> to_array;
}

sub find_by_id ($self, $id) {
    my $db = $self -> pg -> db;
    my $results = $db -> query('SELECT * FROM public.history WHERE id = ?', $id);

    return $results -> hash;
}

sub count_all ($self) {
    my $db = $self -> pg -> db;
    my $results = $db -> query('SELECT COUNT(*) AS total FROM public.history');

    return $results -> hash->{total};
}

sub create ($self, $data) {
    my $db = $self -> pg -> db;

    my $source = $data->{source};
    if (!$source) {
        $source = undef;
    }

    if (defined $data->{datetime} && $data->{datetime} ne q{}) {
        my $results = $db -> query(
            'INSERT INTO public.history (id_company, source, datetime, status) VALUES (?, ?, ?, ?) RETURNING *',
            $data->{id_company},
            $source,
            $data->{datetime},
            $data->{status}
        );

        return $results -> hash;
    }

    my $results = $db -> query(
        'INSERT INTO public.history (id_company, source, status) VALUES (?, ?, ?) RETURNING *',
        $data->{id_company},
        $source,
        $data->{status}
    );

    return $results -> hash;
}

sub update ($self, $id, $data) {
    my $db = $self -> pg -> db;

    my $source = $data->{source};
    if (!$source) {
        $source = undef;
    }

    if (defined $data->{datetime} && $data->{datetime} ne q{}) {
        my $results = $db -> query(
            'UPDATE public.history SET id_company = ?, source = ?, datetime = ?, status = ? WHERE id = ? RETURNING *',
            $data->{id_company},
            $source,
            $data->{datetime},
            $data->{status},
            $id
        );

        return $results -> hash;
    }

    my $results = $db -> query(
        'UPDATE public.history SET id_company = ?, source = ?, status = ? WHERE id = ? RETURNING *',
        $data->{id_company},
        $source,
        $data->{status},
        $id
    );

    return $results -> hash;
}

sub remove ($self, $id) {
    my $db = $self -> pg -> db;
    my $results = $db -> query(
        'DELETE FROM public.history WHERE id = ? RETURNING *',
        $id
    );

    return $results -> hash;
}

1;
