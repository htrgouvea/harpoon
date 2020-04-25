package Worker::EmailTemplate;

use strict;
use warnings;
use Config::Simple;

sub get {
    my $config = Config::Simple -> new("./env/email.conf");

    my $from    = $config -> param("from");
    my $subject = $config -> param("subject");
    my $content = $config -> param("content");

    my %structure = (
        "from" => $from,
        "subject" => $subject,
        "content" => $content
    );

    return %structure;
}

1;