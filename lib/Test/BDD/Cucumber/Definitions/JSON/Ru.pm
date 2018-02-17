package Test::BDD::Cucumber::Definitions::JSON::Ru;

use strict;
use warnings;
use utf8;

use Test::BDD::Cucumber::StepFile qw(Given When Then);
use Test::BDD::Cucumber::Definitions::JSON qw(:util);

=encoding utf8

=head1 NAME

Test::BDD::Cucumber::Definitions::JSON::Ru - Шаги на русском языке для работы
с данными в формате JSON

=cut

our $VERSION = '0.13';

## no critic [RegularExpressions::ProhibitCaptureWithoutTest]
## no critic [RegularExpressions::RequireExtendedFormatting]
## no critic [RegularExpressions::ProhibitComplexRegexes]

=head1 SYNOPSIS

В файле B<features/step_definitions/json_steps.pl>:

    #!/usr/bin/perl

    use strict;
    use warnings;
    use utf8;
    use open qw(:std :utf8);

    use Test::BDD::Cucumber::Definitions::HTTP::Ru;
    use Test::BDD::Cucumber::Definitions::JSON::Ru;

В файле B<features/json.feature>:

    Feature: JSON (Ru)
        Проверка данных в форматe JSON

    Scenario: HTML->JSON
        When HTTP-запрос "GET" отправлен на "https://fastapi.metacpan.org/v1/distribution/Test-BDD-Cucumber-Definitions"
        When содержимое HTTP-ответа декодировано как "JSON"
        Then элемент структуры данных "$.name" совпадает с "Test-BDD-Cucumber-Definitions"

=head1 ИСТОЧНИКИ ДАННЫХ

Данные в формате JSON могут быть прочитаны из различных источников.

Некоторые источники (например, файлы) могут быть прочитаны встроенными
средствами модуля, а для некоторых источников (например, HTTP) требуется
совместное использование вместе с другими модулями.

=over 4

=item B<HTTP> - Данные из HTTP-ответа, полученного с помощью модуля L<Test::BDD::Cucumber::Definitions::HTTP::Ru>

=back

=head1 ШАГИ

=head2 Чтение данных

=pod

Прочитать данные из HTTP-ответа:

    When содержимое HTTP-ответа декодировано как JSON

=cut

# http response content decode JSON
When qr/содержимое HTTP-ответа декодировано как JSON/, sub {
    content_decode();
};

=head2 Проверка данных

Для обращения к произвольным элементам структуры данных используется
L<JSON::Path>.

=pod

Проверить элемент на точное соответствие значению:

    Then элемент структуры данных "$.status" равен "success"

=cut

# data structure jsonpath "" eq ""
Then qr/элемент структуры данных "(.+?)" равен "(.+)"/, sub {
    my ( $jsonpath, $value ) = ( $1, $2 );

    jsonpath_eq( $jsonpath, $value );
};

=pod

Проверить элемент на совпадение с регулярным выражением:

    Then элемент структуры данных "$.name" совпадает с "Test-*"

=cut

# data structure jsonpath "" re ""
Then qr/элемент структуры данных "(.+?)" совпадает с "(.+)"/, sub {
    my ( $jsonpath, $value ) = ( $1, $2 );

    jsonpath_re( $jsonpath, $value );
};

1;

=head1 AUTHOR

Mikhail Ivanov C<< <m.ivanych@gmail.com> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2018 Mikhail Ivanov.

This is free software; you can redistribute it and/or modify it
under the same terms as the Perl 5 programming language system itself.

=pod
