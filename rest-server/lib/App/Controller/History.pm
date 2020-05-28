package App::Controller::History;

use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';

sub index {
    my ($self) = @_;

    $self -> render (
      json => $self -> history -> all
    );
}

sub show {
    my ($self) = @_;

    $self -> render (
		json => $self -> history -> find (
        	$self -> param('id')
      	)
    );
}

sub remove {
	my ($self) = @_;

	$self -> history -> remove (
		$self -> param('id')
	);

	$self -> render (
		json => $self -> history -> find (
        	$self -> param('id')
      	)
    );
}

sub store {
	my ($self) = @_;

	my $validation = $self -> _validation();

	return $self -> render (
		action => 'create', 
		history => {}
	) if $validation -> has_error;

	my $id = $self -> history -> add($validation -> output);

	$self -> redirect_to('/history');
}

sub update {
	my ($self) = @_;

	my $validation = $self -> _validation();

	return $self -> render (
		action => 'edit',
		alert => {}
	) if $validation -> has_error;

	my $id = $self -> param('id');
	$self -> history -> save($id, $validation -> output);

	$self -> render (
		json => $self -> history -> all
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
