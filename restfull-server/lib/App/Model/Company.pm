package App::Model::Company;

use strict;
use warnings;
use Mojo::Base -base;

has 'mysql';

sub add {
	my ($self, $company) = @_;

	return $self -> mysql -> db -> insert (
		'company', $company, {
			returning => 'id'
		}
	) -> hash -> {id};
}

sub all {
	my ($self) = @_;

	$self -> mysql -> db -> select (
		'company'
	) -> hashes -> to_array;
}

sub find {
	my ($self, $id) = @_;

	return $self -> mysql -> db -> select (
		'company', undef, {
			id => $id
		}
	) -> hash;
}

sub remove {
	my ($self, $id) = @_;

	$self -> mysql -> db -> delete (
		'company', {
			id => $id
		}
	);
}

sub save {
	my ($self, $id, $company) = @_;

	$self -> mysql -> db -> update (
		'company', $company, {
			id => $id
		}
	);
}

1;
