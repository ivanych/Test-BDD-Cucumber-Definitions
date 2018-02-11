package Test::BDD::Cucumber::Definitions::HTTP::Ru;

use strict;
use warnings;
use utf8;

use Test::BDD::Cucumber::StepFile qw(Given When Then);
use Test::BDD::Cucumber::Definitions::HTTP qw(C :util);

our $VERSION = '0.12';

## no critic [RegularExpressions::ProhibitCaptureWithoutTest]
## no critic [RegularExpressions::RequireExtendedFormatting]
## no critic [RegularExpressions::ProhibitComplexRegexes]

# http request header "" set ""
When qr/заголовок HTTP-запроса "(.+?)" установлен в значение "(.+)"/, sub {
    my ( $header, $value ) = ( $1, $2 );

    header_set( $header, $value );
};

# http request content set
When qr/тело HTTP-запроса заполнено данными/, sub {
    my ($content) = C->data();

    content_set($content);
};

# http request "" send ""
When qr/HTTP-запрос "(.+?)" отправлен на "(.+)"/, sub {
    my ( $method, $url ) = ( $1, $2 );

    request_send( $method, $url );
};

# http response code eq ""
Then qr/код HTTP-ответа равен "(.+)"/, sub {
    my ($code) = ($1);

    code_eq($code);
};

# http response header "" eq ""
Then qr/заголовок HTTP-ответа "(.+?)" равен "(.+)"/, sub {
    my ( $name, $value ) = ( $1, $2 );

    header_eq( $name, $value );
};

# http response header "" re ""
Then qr/заголовок HTTP-ответа "(.+)" совпадает с "(.+)"/, sub {
    my ( $name, $value ) = ( $1, $2 );

    header_re( $name, $value );
};

# http response content eq ""
Then qr/содержимое HTTP-ответа равно "(.+)"/, sub {
    my ($value) = ($1);

    content_eq($value);
};

# http response content re ""
Then qr/содержимое HTTP-ответа совпадает с "(.+)"/, sub {
    my ($value) = ($1);

    content_re($value);
};

1;
