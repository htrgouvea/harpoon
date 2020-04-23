package Entities::Company;

use strict;
use warnings;
use Data::Dumper;

sub new {
    my ($self, $id) = @_;

    my $dbi = Entities::Connector -> DBI();

    $dbi -> create_model("company");

    my $company = $dbi -> model("company") -> select([
        "NAME",
        "EMAIL",
    ], where => {ID_COMPANY => $id});

    my %data = (
		"name" => "",
		"email"  => ""
	);
	

    while (my $item = $company-> fetch_hash) {
        $data{name} = $item -> {NAME},
        $data{email} = $item -> {EMAIL}
    }

    return %data;
}

1;