package Harpoon::API::Repository::Company;

our $VERSION = '0.01';

use strict;
use warnings;

use Mojo::Base -base, -signatures;

has 'pg';

sub find_all ($self, $limit, $offset) {
    my $db = $self -> pg -> db;

    if (!defined $limit) {
        my $results = $db -> query('SELECT * FROM public.company ORDER BY id');
        return $results -> hashes -> to_array;
    }

    my $results = $db -> query(
        'SELECT * FROM public.company ORDER BY id LIMIT ? OFFSET ?',
        $limit,
        $offset
    );

    return $results -> hashes -> to_array;
}

sub find_by_id ($self, $id) {
    my $db = $self -> pg -> db;
    my $results = $db -> query(
        'SELECT * FROM public.company WHERE id = ?',
        $id
    );

    return $results -> hash;
}

sub create ($self, $data) {
    my $db = $self -> pg -> db;
    my $results = $db -> query(
        'INSERT INTO public.company (name, email, status) VALUES (?, ?, ?) RETURNING *',
        $data->{name},
        $data->{email},
        $data->{status}
    );

    return $results -> hash;
}

sub update ($self, $id, $data) {
    my $db = $self -> pg -> db;
    my $results = $db -> query(
        'UPDATE public.company SET name = ?, email = ?, status = ? WHERE id = ? RETURNING *',
        $data->{name},
        $data->{email},
        $data->{status},
        $id
    );

    return $results -> hash;
}

sub remove ($self, $id) {
    my $db = $self -> pg -> db;
    my $results = $db -> query(
        'DELETE FROM public.company WHERE id = ? RETURNING *',
        $id
    );

    return $results -> hash;
}

1;
