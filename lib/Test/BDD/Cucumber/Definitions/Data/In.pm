package Test::BDD::Cucumber::Definitions::Data::In;

use strict;
use warnings;

use Test::BDD::Cucumber::StepFile qw(Given When Then);
use Test::BDD::Cucumber::Definitions::Data qw(:util);

our $VERSION = '0.11';

## no critic [RegularExpressions::ProhibitCaptureWithoutTest]
## no critic [RegularExpressions::RequireExtendedFormatting]

# http response content decode ""
When qr/http response content decode "(.+)"/, sub {
    my ($format) = ($1);

    content_decode($format);
};

# data structure jsonpath "" eq ""
Then qr/data structure jsonpath "(.+?)" eq "(.+)"/, sub {
    my ( $jsonpath, $value ) = ( $1, $2 );

    jsonpath_eq( $jsonpath, $value );
};

# data structure jsonpath "" re ""
Then qr/data structure jsonpath "(.+?)" re "(.+)"/, sub {
    my ( $jsonpath, $value ) = ( $1, $2 );

    jsonpath_re( $jsonpath, $value );
};

1;
