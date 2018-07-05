package Test::BDD::Cucumber::Definitions::Var::Ru;

use strict;
use warnings;
use utf8;

use Test::BDD::Cucumber::Definitions qw(C Given When Then);
use Test::BDD::Cucumber::Definitions::Var qw(Var);

our $VERSION = '0.40';

## no critic [RegularExpressions::ProhibitCaptureWithoutTest]
## no critic [RegularExpressions::RequireExtendedFormatting]
## no critic [RegularExpressions::ProhibitComplexRegexes]

=encoding utf8

=head1 NAME

Test::BDD::Cucumber::Definitions::Var::Ru - Шаги на русском языке для работы
с переменными

=head1 SYNOPSIS

В файле B<features/step_definitions/var_steps.pl>:

    #!/usr/bin/perl

    use strict;
    use warnings;
    use utf8;
    use open qw(:std :utf8);

    use Test::BDD::Cucumber::Definitions::Var::Ru;
    use Test::BDD::Cucumber::Definitions::HTTP::Ru;

В файле B<features/var.feature>:

    Feature: Var (Ru)
        Работа с переменными

    Scenario: Создание переменной
        Given переменной сценария "code" присвоено значение "200"
        When HTTP-запрос "GET" отправлен на "http://metacpan.org"
        Then код HTTP-ответа равен "S{code}"

=head1 ШАГИ

=cut

sub import {

=head2 Создание переменной

=pod

Создание переменной:

    Given переменной сценария "user" присвоено значение "name"

=cut

    #        var scenario var "(.+?)" set "(.*)"
    Given qr/переменной сценария "(.+?)" присвоено значение "(.*)"/, sub {
        Var->scenario_var_set( $1, $2 );
    };

=pod

Создание переменной со случайным значением (символы из диапазона Base62):

    Given переменной сценария "password" присвоено случайное значение длиной "6" символов

=cut

    #        var scenario var "(.+?)" random "(.*)"
    Given
        qr/переменной сценария "(.+?)" присвоено случайное значение длиной "(.*)" символов/,
        sub {
        Var->scenario_var_random( $1, $2 );
        };

=pod

Создание переменной с элементом структуры данных:

    Given переменной сценария "user" присвоен элемент структуры данных "$.user"

=cut

    #        var scenario var "(.+?)" struct "(.*)"
    Given
        qr/переменной сценария "(.+?)" присвоен элемент структуры данных "(.*)"/,
        sub {
        Var->scenario_var_struct( $1, $2 );
        };

    return;
}

1;

=head1 AUTHOR

Mikhail Ivanov C<< <m.ivanych@gmail.com> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2018 Mikhail Ivanov.

This is free software; you can redistribute it and/or modify it
under the same terms as the Perl 5 programming language system itself.

=pod
