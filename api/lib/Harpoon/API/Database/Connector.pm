package Harpoon::API::Database::Connector;

our $VERSION = '0.01';

use strict;
use warnings;

use Mojo::Pg;
use Mojo::Util qw(url_escape);

use constant DEFAULT_PORT => 5432;
use constant MAX_CONNECTIONS => 20;

sub build_pg {
    my $user = $ENV{DATABASE_USER};
    my $host = $ENV{DATABASE_HOST};
    my $database = $ENV{DATABASE_NAME};
    my $password = $ENV{DATABASE_PASSWORD};
    my $port = $ENV{DATABASE_PORT};

    if (!defined $user) {
        $user = 'postgres';
    }

    if (!defined $host) {
        $host = '127.0.0.1';
    }

    if (!defined $database) {
        $database = 'postgres';
    }

    if (!defined $password) {
        $password = q{};
    }

    if (!defined $port) {
        $port = DEFAULT_PORT;
    }

    my $dsn = sprintf
        'postgresql://%s:%s@%s:%s/%s',
        url_escape($user),
        url_escape($password),
        $host,
        $port,
        url_escape($database);

    my $pg = Mojo::Pg -> new($dsn);
    $pg -> max_connections(MAX_CONNECTIONS);

    return $pg;
}

1;
