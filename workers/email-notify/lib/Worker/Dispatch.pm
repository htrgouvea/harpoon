package Worker::Dispatch;

use strict;
use warnings;
use Try::Tiny;
use Worker::Transport;
use Email::MIME;
use Email::Sender::Simple qw(sendmail);

sub new {
    my ($self, $id, $idCompany, $ref, $content, $date, $recipient) = @_;

    my $transport = Worker::Transport -> new();

    my $htmlbody = "
        <html>
            <body>
                <h1>Report Boletim</h1>
                <h3>
                    <p>
                        <br>
                        Uranus automated monitoring systems have detected a possible incident:<br>
                        <br>
                        <br>
                        ID: $id<br>
                        DATE: $date<br>
                        URL: http://pastebin.com/$ref<br>
                        CONTENT: $content<br>
                    </p>
                </h3>
                <h4>
                    <p>This e-mail was sent in an automated way and its disclosure is prohibited.</p>
                </h4>
            </body>
        </html>
    ";

    my $message = Email::MIME -> create (
        attributes  => {
            content_type => 'multipart/alternative',
            charset      => 'UTF-8',
        },
        header_str  => [
            From    => "Heitor Gouvêa <hi\@heitorgouvea.me",
            To      => $recipient,
            Subject => "Report Boletim by Uranus",
        ],
        parts => [
            Email::MIME -> create (    
                attributes => { content_type => 'text/html' },
                body       => $htmlbody,
            )
        ],
    );

    try {
        sendmail(
            $message, { 
                transport => $transport
            }
        );
    }
    
    catch {
        die "Error sending email: $_";
    };

    return 1;
}   

1;