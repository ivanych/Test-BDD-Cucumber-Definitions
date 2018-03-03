package Test::BDD::Cucumber::Definitions::Struct;

use strict;
use warnings;

use DDP ( show_unicode => 1 );
use Exporter qw(import);
use JSON::Path qw(jpath jpath1);
use JSON::XS;
use Params::ValidationCompiler qw(validation_for);
use List::Util qw(any);
use Test::BDD::Cucumber::Definitions qw(S);
use Test::BDD::Cucumber::Definitions::Types qw(:all);
use Test::More;
use Try::Tiny;

our $VERSION = '0.21';

our @EXPORT_OK = qw(
    http_response_content_read_json
    zip_archive_members_read_list
    struct_data_element_eq struct_data_array_any_eq
    struct_data_element_re struct_data_array_any_re
    struct_data_array_count
);
our %EXPORT_TAGS = (
    util => [
        qw(
            http_response_content_read_json
            zip_archive_members_read_list
            struct_data_element_eq struct_data_array_any_eq
            struct_data_element_re struct_data_array_any_re
            struct_data_array_count
            )
    ]
);

# Enable JSONPath Embedded Perl Expressions
$JSON::Path::Safe = 0;    ## no critic (Variables::ProhibitPackageVars)

## no critic [Subroutines::RequireArgUnpacking]

sub http_response_content_read_json {

    # Clean data
    S->{struct}->{data} = undef;

    my $error;

    my $decoded_content = S->{http}->{response_object}->decoded_content();

    S->{struct}->{data} = try {
        decode_json($decoded_content);
    }
    catch {
        $error = "Could not read http response content as JSON: $_[0]";

        return;
    };

    if ($error) {
        fail(qq{Http response content was read as JSON});
        diag($error);
    }
    else {
        pass(qq{Http response content was read as JSON});
    }

    diag( 'Http response content = ' . np $decoded_content );

    return;
}

sub zip_archive_members_read_list {

    # Clean data
    S->{struct}->{data} = undef;

    my @members = S->{zip}->{archive}->memberNames();

    S->{struct}->{data} = \@members;

    pass('Zip archive members was read as list');

    return;
}

my $validator_eq = validation_for(
    params => [

        # jsonpath
        { type => TbcdNonEmptyStr },

        # value
        { type => TbcdStr },
    ]
);

sub struct_data_element_eq {
    my ( $jsonpath, $value ) = $validator_eq->(@_);

    my $result = jpath1( S->{struct}->{data}, $jsonpath );

    is( $result, $value, qq{Struct data element "$jsonpath" eq "$value"} );

    diag( 'Data = ' . np S->{struct}->{data} );

    return;
}

sub struct_data_array_any_eq {
    my ( $jsonpath, $value ) = $validator_eq->(@_);

    my @result = jpath( S->{struct}->{data}, $jsonpath );

    my $ok = any { $_ eq $value } @result;

    ok( $ok, qq{Struct data array "$jsonpath" any eq "$value"} );

    diag( 'Find = ' . np @result );
    diag( 'Data = ' . np S->{struct}->{data} );

    return;
}

my $validator_re = validation_for(
    params => [

        # jsonpath
        { type => TbcdNonEmptyStr },

        # regexp
        { type => TbcdRegexpRef },
    ]
);

sub struct_data_element_re {
    my ( $jsonpath, $regexp ) = $validator_re->(@_);

    my $result = jpath1( S->{struct}->{data}, $jsonpath );

    like(
        $result,
        qr/$regexp/,    ## no critic [RegularExpressions::RequireExtendedFormatting]
        qq{Struct data element "$jsonpath" re "$regexp"}
    );

    diag( 'Data = ' . np S->{struct}->{data} );

    return;
}

sub struct_data_array_any_re {
    my ( $jsonpath, $regexp ) = $validator_eq->(@_);

    my @result = jpath( S->{struct}->{data}, $jsonpath );

    my $ok = any {/$regexp/} @result;

    ok( $ok, qq{Struct data array "$jsonpath" any re "$regexp"} );

    diag( 'Find = ' . np @result );
    diag( 'Data = ' . np S->{struct}->{data} );

    return;
}

my $validator_count = validation_for(
    params => [

        # jsonpath
        { type => TbcdNonEmptyStr },

        # count
        { type => TbcdInt },
    ]
);

sub struct_data_array_count {
    my ( $jsonpath, $count ) = $validator_count->(@_);

    my @result = jpath( S->{struct}->{data}, $jsonpath );

    is( scalar @result, $count, qq{Struct data array "$jsonpath" count "$count"} );

    diag( 'Find = ' . np @result );
    diag( 'Data = ' . np S->{struct}->{data} );

    return;
}

1;
