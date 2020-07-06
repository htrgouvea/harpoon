package App::Routes;

use strict;
use warnings;
use Mojo::Base -base;

has "routes";

sub register {
	my ($self) = @_;

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