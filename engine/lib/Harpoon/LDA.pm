package Harpoon::LDA {
    our $VERSION = '0.01';

    use strict;
    use warnings;

    use constant TOPIC_COUNT => 5;
    use constant TOP_WORD_LIMIT => 5;

    # dinamic quantity of topics align lenght of the text
    sub new {
        my ($self, $input) = @_;

        if ($input) {
            my @documentos = (
                "$input"
            );

            foreach my $documento (@documentos) {
                $documento =~ s/[[:punct:]]//gmsx;
                $documento = lc $documento;
                $documento =~ s/\b\p{IsAlpha}{1,2}\b//gmsx;
            }

            my %contagem_todas_palavras;
            my %contagem_todas_palavras_em_topicos;

            foreach my $documento (@documentos) {
                my @palavras = split m/\s+/msx, $documento;

                foreach my $palavra (@palavras) {
                    $contagem_todas_palavras{$palavra}++;

                    my $topico = TOPIC_COUNT;
                    $contagem_todas_palavras_em_topicos{"$topico"}{$palavra}++;
                }
            }


            foreach my $topico (keys %contagem_todas_palavras_em_topicos) {
                print "Tópico: $topico\n";
                my %palavras_todas = %{$contagem_todas_palavras_em_topicos{$topico}};

                my @palavras_ordenadas = reverse sort {
                    $palavras_todas{$a} <=> $palavras_todas{$b}
                } keys %palavras_todas;

                my $last_index = TOP_WORD_LIMIT - 1;
                if ($last_index > $#palavras_ordenadas) {
                    $last_index = $#palavras_ordenadas;
                }

                foreach my $i (0 .. $last_index) {
                    my $palavra = $palavras_ordenadas[$i];
                    my $contagem = $palavras_todas{$palavra};
                    print "  $palavra ($contagem)\n";
                }
            }
        }

        return;
    }
}

1;
