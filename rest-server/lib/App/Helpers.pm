package App::Helpers;

use strict;
use warnings;
use base 'Mojolicious::Plugin';

sub register {
    my ($self, $app) = @_;

    $app -> helper (
		mypluginhelper => sub { 
			return 'I am your helper and I live in a plugin!';
		}
	);
}   

1;