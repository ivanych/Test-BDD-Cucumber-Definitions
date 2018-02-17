package Test::BDD::Cucumber::Definitions::JSON::In;

use strict;
use warnings;

use Test::BDD::Cucumber::StepFile qw(Given When Then);
use Test::BDD::Cucumber::Definitions::JSON qw(:util);

our $VERSION = '0.13';

## no critic [RegularExpressions::ProhibitCaptureWithoutTest]
## no critic [RegularExpressions::RequireExtendedFormatting]

# http response content decode JSON
When qr/http response content decode JSON/, sub {
    content_decode();
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
