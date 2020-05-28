package App::Model::Alert;

use strict;
use warnings;
use Mojo::Base -base;

has 'mysql';

sub add {
	my ($self, $alert) = @_;

	return $self -> mysql -> db -> insert (
		'alert', $alert, {
			returning => 'id'
		}
	) -> hash -> {id};
}

sub all {
	my ($self) = @_;

	$self -> mysql -> db -> select (
		'alert'
	) -> hashes -> to_array;
}

sub find {
	my ($self, $id) = @_;

	return $self -> mysql -> db -> select (
		'alert', undef, {
			id => $id
		}
	) -> hash;
}

sub remove {
	my ($self, $id) = @_;

	$self -> mysql -> db -> delete (
		'alert', {
			id => $id
		}
	);
}

sub save {
	my ($self, $id, $alert) = @_;

	$self -> mysql -> db -> update (
		'alert', $alert, {
			id => $id
		}
	);
}

1;
