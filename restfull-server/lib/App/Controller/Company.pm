package App::Controller::Company;

use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';

sub index {
    my ($self) = @_;

    $self -> render (
      json => $self -> company -> all
    );
}

sub show {
    my ($self) = @_;

    $self -> render (
		json => $self -> company -> find (
        	$self -> param('id')
      	)
    );
}

sub remove {
	my ($self) = @_;

	$self -> company -> remove (
		$self -> param('id')
	);

	$self -> render (
		json => $self -> alert -> find (
        	$self -> company('id')
      	)
    );
}

sub store {
	my ($self) = @_;

	my $validation = $self -> _validation();

	return $self -> render (
		action => 'create', 
		company => {}
	) if $validation -> has_error;

	my $id = $self -> company -> add($validation -> output);

	$self -> redirect_to('/company');
}

sub update {
	my ($self) = @_;

	my $validation = $self -> _validation();

	return $self -> render (
		action => 'edit',
		alert => {}
	) if $validation -> has_error;

	my $id = $self -> param('id');
	$self -> company -> save($id, $validation -> output);

	$self -> render (
		json => $self -> company -> all
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
