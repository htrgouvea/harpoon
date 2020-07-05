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

	my $routes = $self -> routes();

	$routes -> get("/" => sub {
		shift -> redirect_to("/company")
	});

	$routes -> get("/company") -> to("company#index");
	$routes -> get("/company/:id") -> to ("company#show");
	$routes -> post("/company") -> to ("company#store");
	$routes -> put("/company/:id") -> to("company#update");
	$routes -> delete("/company/:id") -> to("company#remove");

	$routes -> get("/rule") -> to("rule#index");
	$routes -> get("/rule/:id") -> to ("rule#show");
	$routes -> post("/rule") -> to ("rule#store");
	$routes -> put("/rule/:id") -> to("rule#update");
	$routes -> delete("/rule/:id") -> to("rule#remove");

	$routes -> get("/alert") -> to("alert#index");
	$routes -> get("/alert/:id") -> to ("alert#show");
	$routes -> post("/alert") -> to ("alert#store");
	$routes -> put("/alert/:id") -> to("alert#update");
	$routes -> delete("/alert/:id") -> to("alert#remove");

	$routes -> get("/history") -> to("history#index");
	$routes -> get("/history/:id") -> to ("history#show");
	$routes -> post("/history") -> to ("history#store");
	$routes -> put("/history/:id") -> to("history#update");
	$routes -> delete("/history/:id") -> to("history#remove");
}

1;
