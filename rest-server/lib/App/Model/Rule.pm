package App::Model::Rule;

use strict;
use warnings;
use Mojo::Base -base;

has 'mysql';

sub add {
	my ($self, $rule) = @_;

	return $self -> mysql -> db -> insert (
		'rule', $rule, {
			returning => 'id'
		}
	) -> hash -> {id};
}

sub all {
	my ($self) = @_;

	$self -> mysql -> db -> select (
		'rule'
	) -> hashes -> to_array;
}

sub find {
	my ($self, $id) = @_;

	return $self -> mysql -> db -> select (
		'rule', undef, {
			id => $id
		}
	) -> hash;
}

sub remove {
	my ($self, $id) = @_;

	$self -> mysql -> db -> delete (
		'rule', {
			id => $id
		}
	);
}

sub save {
	my ($self, $id, $rule) = @_;

	$self -> mysql -> db -> update (
		'rule', $rule, {
			id => $id
		}
	);
}

1;
