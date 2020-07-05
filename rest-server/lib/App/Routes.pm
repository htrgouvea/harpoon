package App::Routes;

use strict;
use warnings;
use Mojolicious::Routes;

sub new {
	my ($self) = @_;
	
	my $routes = Mojolicious::Routes -> new();
	my $app    = $routes -> under("/");

	$app -> get("/" => sub {
		shift -> redirect_to("/company")
	});

	$app -> get("/company") -> to("company#index");
	$app -> get("/company/:id") -> to ("company#show");
	$app -> post("/company") -> to ("company#store");
	$app -> put("/company/:id") -> to("company#update");
	$app -> delete("/company/:id") -> to("company#remove");

	$app -> get("/rule") -> to("rule#index");
	$app -> get("/rule/:id") -> to ("rule#show");
	$app -> post("/rule") -> to ("rule#store");
	$app -> put("/rule/:id") -> to("rule#update");
	$app -> delete("/rule/:id") -> to("rule#remove");

	$app -> get("/alert") -> to("alert#index");
	$app -> get("/alert/:id") -> to ("alert#show");
	$app -> post("/alert") -> to ("alert#store");
	$app -> put("/alert/:id") -> to("alert#update");
	$app -> delete("/alert/:id") -> to("alert#remove");

	$app -> get("/history") -> to("history#index");
	$app -> get("/history/:id") -> to ("history#show");
	$app -> post("/history") -> to ("history#store");
	$app -> put("/history/:id") -> to("history#update");
	$app -> delete("/history/:id") -> to("history#remove");

	return $routes;
}

1;