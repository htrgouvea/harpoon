package Harpoon::Semantic_Similarity {
    our $VERSION = '0.01';

    use strict;
    use warnings;

    sub new {
        my ($self, $texto1, $texto2) = @_;

        my @palavras1 = split m/\s+/msx, $texto1;
        my @palavras2 = split m/\s+/msx, $texto2;

        # Cria conjuntos das palavras em cada texto
        my %conjunto1 = map { lc() => 1 } @palavras1;  # Convertendo para minúsculas
        my %conjunto2 = map { lc() => 1 } @palavras2;  # Convertendo para minúsculas

        # Calcula a interseção das palavras nos dois textos
        my $intersecao = 0;
        foreach my $palavra (keys %conjunto1) {
            if (exists $conjunto2{$palavra}) {
                $intersecao++;
            }
        }

        # Calcula a similaridade como a fração da interseção sobre a média do tamanho dos textos
        my $tamanho_medio = (scalar @palavras1 + scalar @palavras2) / 2;
        my $similaridade = $intersecao / $tamanho_medio;

        return $similaridade;
    }
}

1;
