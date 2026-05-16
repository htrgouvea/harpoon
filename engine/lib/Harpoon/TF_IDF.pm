#!/usr/bin/env perl

use 5.030;
use strict;
use warnings;

our $VERSION = '0.01';

sub calcular_tf {
    my ($palavra, $documento) = @_;
    my @palavras = split m/\s+/msx, $documento;
    my $frequencia = 0;

    foreach my $word (@palavras) {
        if (lc $word eq lc $palavra) {
            $frequencia++;
        }
    }

    return $frequencia / scalar @palavras;
}

sub calcular_idf {
    my ($palavra, @documentos) = @_;
    my $documentos_contendo_palavra = 0;

    foreach my $documento (@documentos) {
        my @palavras = split m/\s+/msx, $documento;
        foreach my $word (@palavras) {
            if (lc $word eq lc $palavra) {
                $documentos_contendo_palavra++;
                last;
            }
        }
    }

    return log(scalar @documentos / ($documentos_contendo_palavra + 1));
}

sub calcular_tfidf {
    my ($palavra, $documento, @documentos) = @_;
    my $tf = calcular_tf($palavra, $documento);
    my $idf = calcular_idf($palavra, @documentos);

    return $tf * $idf;
}

my $documento1 = q{Este é o primeiro documento de exemplo. exemplo exemplo exemplo exemplo exemplo};
my $documento2 = q{Este é o segundo documento do exemplo com conteúdo similar. exemplo exemplo };

my $palavra_alvo = q{exemplo};

my $tfidf1 = calcular_tfidf($palavra_alvo, $documento1, $documento1, $documento2);
my $tfidf2 = calcular_tfidf($palavra_alvo, $documento2, $documento1, $documento2);

print "TF-IDF no Documento 1: $tfidf1\n";
print "TF-IDF no Documento 2: $tfidf2\n";
