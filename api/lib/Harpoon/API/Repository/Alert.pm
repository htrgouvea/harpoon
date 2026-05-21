package Harpoon::API::Repository::Alert;

our $VERSION = '0.01';

use strict;
use warnings;

use Mojo::Base -base, -signatures;

has 'pg';

sub find_all ($self, $limit, $offset) {
    my $db = $self -> pg -> db;

    if (!defined $limit) {
        my $results = $db -> query('SELECT * FROM public.alert ORDER BY id');
        return $results -> hashes -> to_array;
    }

    my $results = $db -> query(
        'SELECT * FROM public.alert ORDER BY id LIMIT ? OFFSET ?',
        $limit,
        $offset
    );

    return $results -> hashes -> to_array;
}

sub find_by_id ($self, $id) {
    my $db = $self -> pg -> db;
    my $results = $db -> query('SELECT * FROM public.alert WHERE id = ?', $id);

    return $results -> hash;
}

sub count_all ($self) {
    my $db = $self -> pg -> db;
    my $results = $db -> query('SELECT COUNT(*) AS total FROM public.alert');

    return $results -> hash->{total};
}

sub create ($self, $data) {
    my $db = $self -> pg -> db;
    my $results = $db -> query(
        'INSERT INTO public.alert (id_company, status, notification, content, hash) VALUES (?, ?, ?, ?, ?) RETURNING *',
        $data->{id_company},
        $data->{status},
        $data->{notification},
        $data->{content},
        $data->{hash}
    );

    return $results -> hash;
}

sub update ($self, $id, $data) {
    my $db = $self -> pg -> db;

    if ($data->{datetime}) {
        my $results = $db -> query(
            'UPDATE public.alert SET id_company = ?, datetime = ?, status = ?, notification = ?, content = ?, hash = ? WHERE id = ? RETURNING *',
            $data->{id_company},
            $data->{datetime},
            $data->{status},
            $data->{notification},
            $data->{content},
            $data->{hash},
            $id
        );

        return $results -> hash;
    }

    my $results = $db -> query(
        'UPDATE public.alert SET id_company = ?, status = ?, notification = ?, content = ?, hash = ? WHERE id = ? RETURNING *',
        $data->{id_company},
        $data->{status},
        $data->{notification},
        $data->{content},
        $data->{hash},
        $id
    );

    return $results -> hash;
}

sub remove ($self, $id) {
    my $db = $self -> pg -> db;
    my $results = $db -> query(
        'DELETE FROM public.alert WHERE id = ? RETURNING *',
        $id
    );

    return $results -> hash;
}

1;
