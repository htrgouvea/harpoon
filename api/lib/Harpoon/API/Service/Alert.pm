package Harpoon::API::Service::Alert;

our $VERSION = '0.01';

use strict;
use warnings;

use Mojo::Base -base, -signatures;

has 'repository';

sub get_all ($self, $limit, $offset) {
    return $self -> repository -> find_all($limit, $offset);
}

sub get_by_id ($self, $id) {
    return $self -> repository -> find_by_id($id);
}

sub create ($self, $data) {
    return $self -> repository -> create($data);
}

sub update ($self, $id, $data) {
    return $self -> repository -> update($id, $data);
}

sub remove ($self, $id) {
    return $self -> repository -> remove($id);
}

1;
