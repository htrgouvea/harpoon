package Harpoon::Crawler::DetectionStore;

our $VERSION = '0.01';

use strict;
use warnings;

sub new {
    my ($class, $database_handle) = @_;

    return bless {
        database_handle => $database_handle
    }, $class;
}

sub create_model {
    my ($self, $model_name) = @_;

    $self->{database_handle} -> create_model($model_name);

    return;
}

sub record_exists {
    my ($self, $model_name, $column_name, $value) = @_;

    my $query = $self->{database_handle} -> model($model_name) -> select(
        [$column_name], where => {$column_name => $value}
    );
    my $row = $query -> fetch;

    return defined $row ? 1 : 0;
}

sub insert_record {
    my ($self, $model_name, $data) = @_;

    return $self->{database_handle} -> model($model_name) -> insert($data);
}

1;
