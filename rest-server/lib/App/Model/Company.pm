package App::Model::Company;

use strict;
use warnings;
use Mojo::Base -base;

has 'mysql';

sub add {
	my ($self, $company) = @_;

	$self -> mysql -> db -> insert (
		'company', $company, {
			returning => 'id'
		}
	) -> hash -> {id};
}

sub all {
	my ($self) = @_;

	return $self -> mysql -> db -> select (
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

	return $self -> mysql -> db -> delete (
		'company', {
			id => $id
		}
	);
}

sub save {
	my ($self, $id, $email, $name, $manager, $status, $phone) = @_;

	$self -> mysql -> db -> update (
		'company', $email, {
			id => $id
		}
	);
}

1;