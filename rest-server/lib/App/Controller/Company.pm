package App::Controller::Company;

use strict;
use warnings;
use Mojo::Base "Mojolicious::Controller";

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
        	$self -> param("id")
      	)
    );
}

sub remove {
	my ($self) = @_;

	$self -> company -> remove (
		$self -> param("id")
	);

	$self -> render (
		json => $self -> company -> find (
        	$self -> company("id")
      	)
    );
}

sub store {
	my ($self) = @_;

	my $request = $self -> req -> json;

 	# say Dumper($self -> req -> json);

    my $validation = $self -> validation;

    # $validation -> required("email");
    # $validation -> required("name");
	# $validation -> required("manager");
	# $validation -> required("status");

    if ($validation -> has_error()) {
        return $self -> render (
			json => "error"
		);
    }

	my $email   = $self -> param("email");
	my $name    = $self -> param("name");
	my $manager = $self -> param("manager");
	my $status  = $self -> param("status");
	my $phone   = $self -> param("phone");

	$self -> company -> add (
		$email, $validation -> output
	);

	$self -> redirect_to("/company");
}

sub update {
	my ($self) = @_;

	my $id      = $self -> param("id");
	my $email   = $self -> param("email");
	my $name    = $self -> param("name");
	my $manager = $self -> param("manager");
	my $status  = $self -> param("status");
	my $phone   = $self -> param("phone");

	$self -> company -> save (
		$id, $email, $name, $manager, $status, $phone
	);

	$self -> render (
		json => $self -> company -> all
	);
}

sub _validation {
	my ($self) = @_;

	my $validation = $self -> validation();

	$validation -> required("email");
	$validation -> required("name");
	$validation -> required("status");
	$validation -> required("manager");

	return $validation;
}

1;