package Test::BDD::Cucumber::Definitions::File::Ru;

use strict;
use warnings;
use utf8;
use DDP;
use Test::BDD::Cucumber::Definitions qw(Given When Then);
use Test::BDD::Cucumber::Definitions::File qw(:util);

our $VERSION = '0.27';

## no critic [RegularExpressions::ProhibitCaptureWithoutTest]
## no critic [RegularExpressions::RequireExtendedFormatting]
## no critic [RegularExpressions::ProhibitComplexRegexes]

=encoding utf8

=head1 NAME

Test::BDD::Cucumber::Definitions::File::Ru - Шаги на русском языке
для работы с файлами

=head1 SYNOPSIS

В файле B<features/step_definitions/file_steps.pl>:

    #!/usr/bin/perl

    use strict;
    use warnings;
    use utf8;
    use open qw(:std :utf8);

    use Test::BDD::Cucumber::Definitions::File::Ru;

В файле B<features/file.feature>:

    Feature: File (Ru)
        Работа с файлами

    Scenario: File is a directory
        Given задан путь к файлу "/home/user"
        Then файл имеет тип "directory"

=head1 Типы файлов

Файлы могут быть следующих типов (L<согласно документации|https://perldoc.perl.org/functions/-X.html>):

=over 4

=item * B<regular file>

=item * B<directory>

=item * B<symbolic link>

=item * B<fifo>

=item * B<socket>

=item * B<block special file>

=item * B<character special file>

=back

Названия типов совпадают с теми, которые показывает команда C<stat>.

=head1 ШАГИ

=cut

sub import {

=head2 Условия

=pod

Задать путь к файлу (или каталогу):

    Given задан путь к файлу "/var/lib/test.txt"

=cut

    #        file path set "(.*)"
    Given qr/задан путь к файлу "(.*)"/, sub {
        file_path_set($1);
    };

=head2 Действия

=pod

Прочитать содержимое текстового файла:

    When прочитан текстовый файл в кодировке "utf-8"

=cut

    #       file read text "(.*)"
    When qr/прочитан текстовый файл в кодировке "(.*)"/, sub {
        file_read_text($1);
    };

=pod

Прочитать содержимое двоичного файла:

    When прочитан двоичный файл

=cut

    #       file read binary
    When qr/прочитан двоичный файл/, sub {
        file_read_binary();
    };

=head2 Проверки

=pod

Проверить наличие файла:

    When файл существует

=cut

    #       file exists
    Then qr/файл существует/, sub {
        file_exists();
    };

=pod

Проверить отсутствие файла:

    When файл не существует

=cut

    #       file no exists
    Then qr/файл не существует/, sub {
        file_noexists();
    };

=pod

Проверить тип файла:

    When файл имеет тип "regular file"

=cut

    #       file type is "(.*)"
    Then qr/файл имеет тип "(.*)"/, sub {
        file_type_is($1);
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
