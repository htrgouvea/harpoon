#!/usr/bin/env perl

use 5.018;
use strict;
use warnings;
use Find::Lib q{./lib};
use Harpoon::LDA;
use Harpoon::Semantic_Similarity;
# Harpoon:TF_IDF;

our $VERSION = '0.01';

sub main {
    # my $input = q{Este é um texto que conta como Hector};
    my $input = q{jogam uma bomba na igreja};
    my $base = q{Vamos jogar uma bomba na igreja};

    # my $lda = Harpoon::LDA -> new($input, $base);
    my $analysis = Harpoon::Semantic_Similarity -> new ($input, $base);
    print "Similaridade: $analysis\n";

    return 0;
}

exit main();
