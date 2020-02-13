package Worker::Dispatch;

use strict;
use warnings;

sub new {
    my ($self, $id, $ref, $content, $date) = @_;

    print "
        id -> $id
        ref -> $ref 
        content -> 
        
        -----------
        '$content' 
        -----------

        date -> $date\n";

    return 1;
}   

1;