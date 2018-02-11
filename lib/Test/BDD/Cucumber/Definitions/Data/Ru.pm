package Test::BDD::Cucumber::Definitions::Data::Ru;

use strict;
use warnings;
use utf8;

use Test::BDD::Cucumber::StepFile qw(Given When Then);
use Test::BDD::Cucumber::Definitions::Data qw(:util);

our $VERSION = '0.12';

## no critic [RegularExpressions::ProhibitCaptureWithoutTest]
## no critic [RegularExpressions::RequireExtendedFormatting]
## no critic [RegularExpressions::ProhibitComplexRegexes]

# http response content decode ""
When qr/содержимое HTTP-ответа декодировано как "(.+)"/, sub {
    my ($format) = ($1);

    content_decode($format);
};

# data structure jsonpath "" eq ""
Then qr/элемент структуры данных "(.+?)" равен "(.+)"/, sub {
    my ( $jsonpath, $value ) = ( $1, $2 );

    jsonpath_eq( $jsonpath, $value );
};

# data structure jsonpath "" re ""
Then qr/элемент структуры данных "(.+?)" совпадает с "(.+)"/, sub {
    my ( $jsonpath, $value ) = ( $1, $2 );

    jsonpath_re( $jsonpath, $value );
};

1;
