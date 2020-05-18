package Worker::Dispatch;

use strict;
use warnings;
use Try::Tiny;
use Email::MIME;
use Worker::Transport;
use Worker::EmailTemplate;
use Email::Sender::Simple qw(sendmail);

sub new {
    my ($self, $id, $company, $content, $date, $name, $recipient) = @_;

    my $transport = Worker::Transport -> new();
    my %template = Worker::EmailTemplate -> get();

    $template{content} = $template{content} =~ s/\$id/$id/r;
    $template{content} = $template{content} =~ s/\$date/$date/r;
    $template{content} = $template{content} =~ s/\$content/$content/r;

    my $message = Email::MIME -> create (
        attributes  => {
            content_type => "multipart/alternative",
            charset      => "UTF-8",
        },
        header_str  => [
            From    => $template{from},
            To      => $recipient,
            Subject => $template{subject},
        ],
        parts => [
            Email::MIME -> create (    
                attributes => { content_type => "text/html" },
                body       => $template{content}
            )
        ],
    );

    try {
        sendmail(
            $message, { 
                transport => $transport
            }
        );

        return 1;
    }
    
    catch {
        die "Error sending email: $_";
        return 0;
    };

    return 1;
}   

1;