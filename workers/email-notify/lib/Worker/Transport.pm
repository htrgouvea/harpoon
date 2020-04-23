package Worker::Transport;

use strict;
use warnings;
use Config::Simple;
use Email::Sender::Transport::SMTP;

sub new {
    my $config = Config::Simple -> new("./env/smtp.conf");

    my $hostname = $config -> param("smtp_hostname");
    my $port     = $config -> param("smtp_port");
    my $username = $config -> param("smtp_username");
    my $password = $config -> param("smtp_password");

    my $transport = Email::Sender::Transport::SMTP -> new(
        host          => $hostname,
        port          => $port,
        ssl           => "starttls",
        sasl_username => $username,
        sasl_password => $password
    );
    
    return $transport;
}

1;