package Harpoon::API::Repository::Rule;

our $VERSION = '0.01';

use strict;
use warnings;

use Mojo::Base -base, -signatures;

has 'pg';

sub find_all ($self, $limit, $offset) {
    my $db = $self -> pg -> db;

    if (!defined $limit) {
        my $results = $db -> query('SELECT * FROM public.rule ORDER BY id');
        return $results -> hashes -> to_array;
    }

    my $results = $db -> query(
        'SELECT * FROM public.rule ORDER BY id LIMIT ? OFFSET ?',
        $limit,
        $offset
    );

    return $results -> hashes -> to_array;
}

sub find_by_id ($self, $id) {
    my $db = $self -> pg -> db;
    my $results = $db -> query('SELECT * FROM public.rule WHERE id = ?', $id);

    return $results -> hash;
}

sub count_all ($self) {
    my $db = $self -> pg -> db;
    my $results = $db -> query('SELECT COUNT(*) AS total FROM public.rule');

    return $results -> hash->{total};
}

sub create ($self, $data) {
    my $db = $self -> pg -> db;
    my $results = $db -> query(
        'INSERT INTO public.rule (id_company, string, filter, score, description, status) VALUES (?, ?, ?, ?, ?, ?) RETURNING *',
        $data->{id_company},
        $data->{string},
        $data->{filter},
        $data->{score},
        $data->{description},
        $data->{status}
    );

    return $results -> hash;
}

sub update ($self, $id, $data) {
    my $db = $self -> pg -> db;
    my $results = $db -> query(
        'UPDATE public.rule SET id_company = ?, string = ?, filter = ?, score = ?, description = ?, status = ? WHERE id = ? RETURNING *',
        $data->{id_company},
        $data->{string},
        $data->{filter},
        $data->{score},
        $data->{description},
        $data->{status},
        $id
    );

    return $results -> hash;
}

sub remove ($self, $id) {
    my $db = $self -> pg -> db;
    my $results = $db -> query(
        'DELETE FROM public.rule WHERE id = ? RETURNING *',
        $id
    );

    return $results -> hash;
}

1;
