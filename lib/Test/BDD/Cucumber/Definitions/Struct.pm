package Test::BDD::Cucumber::Definitions::Struct;

use strict;
use warnings;

use Carp;
use DDP ( show_unicode => 1 );
use Exporter qw(import);
use JSON::Path 'jpath1';
use Params::ValidationCompiler qw(validation_for);
use Test::BDD::Cucumber::Definitions qw(S);
use Test::BDD::Cucumber::Definitions::TypeConstraints qw(:all);
use Test::More;

our $VERSION = '0.16';

our @EXPORT_OK = qw(
    jsonpath_eq jsonpath_re
);
our %EXPORT_TAGS = (
    util => [
        qw(
            jsonpath_eq jsonpath_re
            )
    ]
);

# Enable JSONPath Embedded Perl Expressions
$JSON::Path::Safe = 0;    ## no critic (Variables::ProhibitPackageVars)

## no critic [Subroutines::RequireArgUnpacking]

my $validator_jsonpath_eq = validation_for(
    params => [

        # data structure jsonpath
        { type => ValueJsonpath },

        # data structure value
        { type => ValueString },
    ]
);

sub jsonpath_eq {
    my ( $jsonpath, $value ) = $validator_jsonpath_eq->(@_);

    my $result = jpath1( S->{struct}->{data}, $jsonpath );

    is( $result, $value, qq{Data structure jsonpath "$jsonpath" eq "$value"} );

    diag( 'Data structure = ' . np S->{struct}->{data} );

    return;
}

my $validator_jsonpath_re = validation_for(
    params => [

        # data structure jsonpath
        { type => ValueJsonpath },

        # data structure regexp
        { type => ValueRegexp },
    ]
);

sub jsonpath_re {
    my ( $jsonpath, $regexp ) = $validator_jsonpath_re->(@_);

    my $result = jpath1( S->{struct}->{data}, $jsonpath );

    like(
        $result,
        qr/$regexp/,    ## no critic [RegularExpressions::RequireExtendedFormatting]
        qq{Data structure jsonpath "$jsonpath" re "$regexp"}
    );

    diag( 'Data structure = ' . np S->{struct}->{data} );

    return;
}

1;
