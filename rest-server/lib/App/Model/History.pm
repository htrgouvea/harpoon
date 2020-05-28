package App::Model::History;

use strict;
use warnings;
use Mojo::Base -base;

has 'mysql';

sub add {
	my ($self, $history) = @_;

	return $self -> mysql -> db -> insert (
		'history', $history, {
			returning => 'id'
		}
	) -> hash -> {id};
}

sub all {
	my ($self) = @_;

	$self -> mysql -> db -> select (
		'history'
	) -> hashes -> to_array;
}

sub find {
	my ($self, $id) = @_;

	return $self -> mysql -> db -> select (
		'history', undef, {
			id => $id
		}
	) -> hash;
}

sub remove {
	my ($self, $id) = @_;

	$self -> mysql -> db -> delete (
		'history', {
			id => $id
		}
	);
}

sub save {
	my ($self, $id, $history) = @_;

	$self -> mysql -> db -> update (
		'history', $history, {
			id => $id
		}
	);
}

1;
