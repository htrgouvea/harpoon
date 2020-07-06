package App;

use strict;
use warnings;
use Mojo::mysql;
use App::Helpers;
use App::Routes;
use App::Model::Company;
use App::Model::Rule;
use App::Model::Alert;
use App::Model::History;
use Mojo::Base "Mojolicious";

sub startup {
	my ($self) = @_;

	$self -> plugin("Config");
	$self -> secrets($self -> config("secrets"));

	$self -> helper (
		mysql => sub {
			state $mysql = Mojo::mysql -> new (
				shift -> config("mysql")
			)
		}
	);

	$self -> helper (
		company => sub {
			state $company = App::Model::Company -> new (
				mysql => shift -> mysql
			)
		}
	);

	$self -> helper( 
		rule => sub {
			state $rule = App::Model::Rule -> new (
				mysql => shift -> mysql
			)
		}
	);

	$self -> helper (
		alert => sub {
			state $alert = App::Model::Alert -> new (
				mysql => shift -> mysql
			)
		}
	);

	$self -> helper (
		history => sub {
			state $history = App::Model::History -> new (
				mysql => shift -> mysql
			)
		}
	);

	my $path = $self -> home -> child("database", "app.sql");
	$self -> mysql -> auto_migrate(1) -> migrations -> name("app") -> from_file($path);

	my $routes = App::Routes -> new(routes => $self -> routes);
	$routes -> register;
}

1;
