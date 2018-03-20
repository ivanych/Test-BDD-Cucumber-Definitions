package Test::BDD::Cucumber::Definitions::File::In;

use strict;
use warnings;
use utf8;

use Test::BDD::Cucumber::Definitions qw(Given When Then);
use Test::BDD::Cucumber::Definitions::File qw(:util);

our $VERSION = '0.26';

## no critic [RegularExpressions::ProhibitCaptureWithoutTest]
## no critic [RegularExpressions::RequireExtendedFormatting]
## no critic [RegularExpressions::ProhibitComplexRegexes]

sub import {

    #        file path set "(.*)"
    Given qr/file path set "(.*)"/, sub {
        file_path_set($1);
    };

    #       file exists
    Then qr/file exists/, sub {
        file_exists();
    };

    #       file no exists
    Then qr/file no exists/, sub {
        file_noexists();
    };

    #       file type is "(.*)"
    Then qr/file type is "(.*)"/, sub {
        file_type_is($1);
    };

    return;
}

1;