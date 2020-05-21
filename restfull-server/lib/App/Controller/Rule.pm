package App::Controller::Rule;

use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';

sub index {
    my ($self) = @_;

    $self -> render (
      json => $self -> rule -> all
    );
}

sub show {
    my ($self) = @_;

    $self -> render (
		json => $self -> rule -> find (
        	$self -> param('id')
      	)
    );
}

sub remove {
	my ($self) = @_;

	$self -> rule -> remove (
		$self -> param('id')
	);

	$self -> redirect_to('/rule');
}

sub store {
	my ($self) = @_;

	my $validation = $self -> _validation();

	return $self -> render (
		action => 'create', 
		rule => {}
	) if $validation -> has_error;

	my $id = $self -> rule -> add($validation -> output);

	$self -> redirect_to('/rule');
}

sub update {
	my ($self) = @_;

	my $validation = $self -> _validation();

	return $self -> render (
		action => 'edit',
		alert => {}
	) if $validation -> has_error;

	my $id = $self -> param('id');
	$self -> rule -> save($id, $validation -> output);

	$self -> render (
		json => $self -> rule -> all
	);

	# $self -> redirect_to('posts');
}

sub _validation {
	my ($self) = @_;

	my $validation = $self -> validation;

	$validation -> required("email");
	$validation -> required("name");
	$validation -> required("status");

	return $validation;
}

1;
