package App::Controller::Alert;

use strict;
use warnings;
use Mojo::Base "Mojolicious::Controller";

sub index {
    my ($self) = @_;

    $self -> render (
		json => $self -> alert -> all
    );
}

sub show {
    my ($self) = @_;

    $self -> render (
		json => $self -> alert -> find (
        	$self -> param("id")
      	)
    );
}

sub remove {
	my ($self) = @_;

	$self -> alert -> remove (
		$self -> param("id")
	);

	$self -> render (
		json => $self -> alert -> find (
        	$self -> param("id")
      	)
    );
}

sub store {
	my ($self) = @_;

	my $validation = $self -> _validation();

	return $self -> render (
		action => "create", 
		alert => {}
	) if $validation -> has_error;

	my $id = $self -> alert -> add($validation -> output);

	$self -> redirect_to("/alert");
}

sub update {
	my ($self) = @_;

	my $validation = $self -> _validation();

	return $self -> render (
		action => "edit",
		alert => {}
	) if $validation -> has_error;

	my $id = $self -> param("id");
	$self -> alert -> save($id, $validation -> output);

	$self -> render (
		json => $self -> alert -> all
	);

	# $self -> redirect_to("posts");
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
