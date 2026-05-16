package Harpoon::API;

our $VERSION = '0.01';

use strict;
use warnings;

use Mojo::Base 'Mojolicious', -signatures;

use Harpoon::API::Database::Connector;
use Harpoon::API::Controller::Alert;
use Harpoon::API::Controller::Company;
use Harpoon::API::Controller::Health;
use Harpoon::API::Controller::History;
use Harpoon::API::Controller::Rule;
use Harpoon::API::Repository::Alert;
use Harpoon::API::Repository::Company;
use Harpoon::API::Repository::History;
use Harpoon::API::Repository::Rule;
use Harpoon::API::Service::Alert;
use Harpoon::API::Service::Company;
use Harpoon::API::Service::History;
use Harpoon::API::Service::Rule;
use Harpoon::API::Util::Environment;

sub startup ($self) {
Harpoon::API::Util::Environment::load('.env');

    my $pg = Harpoon::API::Database::Connector::build_pg();

    my $alert_repository = Harpoon::API::Repository::Alert -> new(pg => $pg);
    my $company_repository = Harpoon::API::Repository::Company -> new(pg => $pg);
    my $history_repository = Harpoon::API::Repository::History -> new(pg => $pg);
    my $rule_repository = Harpoon::API::Repository::Rule -> new(pg => $pg);

    my $alert_service = Harpoon::API::Service::Alert -> new(
        repository => $alert_repository
    );
    my $company_service = Harpoon::API::Service::Company -> new(
        repository => $company_repository
    );
    my $history_service = Harpoon::API::Service::History -> new(
        repository => $history_repository
    );
    my $rule_service = Harpoon::API::Service::Rule -> new(
        repository => $rule_repository
    );

    my $started_at = time;

    my $router = $self -> routes;

    $router -> get('/health') -> to(
        'health#status',
        pg => $pg,
        started_at => $started_at
    );

    $router -> get('/alerts') -> to(
        'alert#list',
        service => $alert_service
    );
    $router -> get('/alerts/:id') -> to(
        'alert#show',
        service => $alert_service
    );
    $router -> post('/alerts') -> to(
        'alert#create',
        service => $alert_service
    );
    $router -> put('/alerts/:id') -> to(
        'alert#update',
        service => $alert_service
    );
    $router -> delete('/alerts/:id') -> to(
        'alert#remove',
        service => $alert_service
    );

    $router -> get('/company') -> to(
        'company#list',
        service => $company_service
    );
    $router -> get('/company/:id') -> to(
        'company#show',
        service => $company_service
    );
    $router -> post('/company') -> to(
        'company#create',
        service => $company_service
    );
    $router -> put('/company/:id') -> to(
        'company#update',
        service => $company_service
    );
    $router -> delete('/company/:id') -> to(
        'company#remove',
        service => $company_service
    );

    $router -> get('/history') -> to(
        'history#list',
        service => $history_service
    );
    $router -> get('/history/:id') -> to(
        'history#show',
        service => $history_service
    );
    $router -> post('/history') -> to(
        'history#create',
        service => $history_service
    );
    $router -> put('/history/:id') -> to(
        'history#update',
        service => $history_service
    );
    $router -> delete('/history/:id') -> to(
        'history#remove',
        service => $history_service
    );

    $router -> get('/rule') -> to(
        'rule#list',
        service => $rule_service
    );
    $router -> get('/rule/:id') -> to(
        'rule#show',
        service => $rule_service
    );
    $router -> post('/rule') -> to(
        'rule#create',
        service => $rule_service
    );
    $router -> put('/rule/:id') -> to(
        'rule#update',
        service => $rule_service
    );
    $router -> delete('/rule/:id') -> to(
        'rule#remove',
        service => $rule_service
    );

    return;
}

1;
