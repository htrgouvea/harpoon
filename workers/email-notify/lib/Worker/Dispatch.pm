package Worker::Dispatch;

use strict;
use warnings;
use Try::Tiny;
use Email::MIME;
use Worker::Transport;
use Email::Sender::Simple qw(sendmail);

sub new {
    my ($self, $id, $company, $content, $date, $name, $recipient) = @_;

    my $transport = Worker::Transport -> new();

    my $htmlTemplate = "
        <html>
            <body>
                <h1>Report Boletim</h1>
                <h3>
                    <p>
                        Uranus automated monitoring systems have detected a possible incident
                        <br><br><br>
                        <span>ID: $id</span><br/>
                        <span>DATE: $date</span><br/>
                        <span>CONTENT: $content</span><br/>
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
            content_type => "multipart/alternative",
            charset      => "UTF-8",
        },
        header_str  => [
            From    => "Uranus <hi\@heitorgouvea.me",
            To      => $recipient,
            Subject => "Report Boletim by Uranus",
        ],
        parts => [
            Email::MIME -> create (    
                attributes => { content_type => "text/html" },
                body       => $htmlTemplate
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