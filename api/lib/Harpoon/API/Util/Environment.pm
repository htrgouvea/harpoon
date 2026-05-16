package Harpoon::API::Util::Environment;

our $VERSION = '0.01';

use strict;
use warnings;

sub load {
    my ($path) = @_;

    if (!defined $path) {
        return;
    }

    if (!-f $path) {
        return;
    }

    open my $file_handle, '<', $path or return;
    my @lines = <$file_handle>;
    close $file_handle or return;

    foreach my $line (@lines) {
        chomp $line;

        if ($line =~ m/^\s*$/msx) {
            next;
        }

        if ($line =~ m/^\s*#/msx) {
            next;
        }

        my ($key, $value) = split m/=/msx, $line, 2;

        if (!defined $key) {
            next;
        }

        if (!defined $value) {
            $value = q{};
        }

        $key =~ s/^\s+//msx;
        $key =~ s/\s+$//msx;
        $value =~ s/^\s+//msx;
        $value =~ s/\s+$//msx;

        if ($key eq q{}) {
            next;
        }

        if (exists $ENV{$key}) {
            next;
        }

        $ENV{$key} = $value; ## no critic (Variables::RequireLocalizedPunctuationVars)
    }

    return;
}

1;
