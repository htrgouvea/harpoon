package App::Model::Alert;

use strict;
use warnings;
use Mojo::Base -base;

has "mariadb";

sub add {
	my ($self, $alert) = @_;

	return $self -> mariadb -> db -> insert (
		"alert", $alert, {
			returning => "id"
		}
	) -> hash -> {id};
}

sub all {
	my ($self) = @_;

	$self -> mariadb -> db -> select (
		"alert"
	) -> hashes -> to_array;
}

sub find {
	my ($self, $id) = @_;

	return $self -> mariadb -> db -> select (
		"alert", undef, {
			id => $id
		}
	) -> hash;
}

sub remove {
	my ($self, $id) = @_;

	$self -> mariadb -> db -> delete (
		"alert", {
			id => $id
		}
	);
}

sub save {
	my ($self, $id, $alert) = @_;

	$self -> mariadb -> db -> update (
		"alert", $alert, {
			id => $id
		}
	);
}

1;
