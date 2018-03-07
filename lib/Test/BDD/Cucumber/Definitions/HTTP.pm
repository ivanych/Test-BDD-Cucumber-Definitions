package Test::BDD::Cucumber::Definitions::HTTP;

use strict;
use warnings;

use Carp;
use Const::Fast;
use DDP ( show_unicode => 1 );
use Exporter qw(import);
use Hash::MultiValue;
use HTTP::Response;
use HTTP::Tiny;
use Params::ValidationCompiler qw(validation_for);
use Test::BDD::Cucumber::Definitions qw(S);
use Test::BDD::Cucumber::Definitions::Types qw(:all);
use Test::More;
use Try::Tiny;

our $VERSION = '0.24';

our @EXPORT_OK = qw(
    http_request_header_set
    http_request_content_set
    http_request_send
    http_response_code_eq
    http_response_header_eq http_response_header_re
    http_response_content_eq http_response_content_re
);

our %EXPORT_TAGS = (
    util => [
        qw(
            http_request_header_set
            http_request_content_set
            http_request_send
            http_response_code_eq
            http_response_header_eq http_response_header_re
            http_response_content_eq http_response_content_re
            )
    ]
);

my $http = HTTP::Tiny->new();

# Exceptions will result in a pseudo-HTTP status code of 599 and a reason of "Internal Exception".
# The content field in the response will contain the text of the exception.
const my $HTTP_INTERNAL_EXCEPTION => 599;

my $validator_eq = validation_for(
    params => [

        # http request header name
        { type => TbcdNonEmptyStr },

        # http request header value
        { type => TbcdStr }
    ]
);

my $validator_q = validation_for(
    params => [

        # http request content value
        { type => TbcdStr },
    ]
);

my $validator_i = validation_for(
    params => [

        # http response code value
        { type => TbcdInt },
    ]
);

my $validator_re = validation_for(
    params => [

        # http response header name
        { type => TbcdNonEmptyStr },

        # http response header regexp
        { type => TbcdRegexpRef }
    ]
);

my $validator_r = validation_for(
    params => [

        # http response content regexp
        { type => TbcdRegexpRef }
    ]
);

my $validator_request_send = validation_for(
    params => [

        # http request method value
        { type => TbcdNonEmptyStr },

        # http request url value
        { type => TbcdNonEmptyStr },
    ]
);

## no critic [Subroutines::RequireArgUnpacking]

sub http_request_header_set {
    my ( $header, $value ) = $validator_eq->(@_);

    S->{http}->{request}->{headers}->{$header} = $value;

    return;
}

sub http_request_content_set {
    my ($content) = $validator_q->(@_);

    S->{http}->{request}->{content} = $content;

    return;
}

sub http_request_send {
    my ( $method, $url ) = $validator_request_send->(@_);

    my $options = {
        headers => S->{http}->{request}->{headers},
        content => S->{http}->{request}->{content},
    };

    S->{http}->{response} = $http->request( $method, $url, $options );

    if ( S->{http}->{response}->{status} == $HTTP_INTERNAL_EXCEPTION ) {
        fail('Http request was sent');
        diag( S->{http}->{response}->{content} );
    }

    diag( 'Http request method = ' . np $method);
    diag( 'Http request url = ' . np $url );
    diag( 'Http request headers = ' . np S->{http}->{request}->{headers} );
    diag( 'Http request content = ' . np S->{http}->{request}->{content} );

    # Clean http request
    S->{http}->{request} = undef;

    S->{http}->{response_object} = HTTP::Response->new(
        S->{http}->{response}->{status},
        S->{http}->{response}->{reason},
        [ Hash::MultiValue->from_mixed( S->{http}->{response}->{headers} )->flatten ],
        S->{http}->{response}->{content},
    );

    return;
}

sub http_response_code_eq {
    my ($code) = $validator_i->(@_);

    is( S->{http}->{response}->{status}, $code, qq{Http response code eq "$code"} );

    diag( sprintf 'Http response status = "%s %s"', S->{http}->{response}->{status}, S->{http}->{response}->{reason} );

    return;
}

sub http_response_header_eq {
    my ( $header, $value ) = $validator_eq->(@_);

    is( S->{http}->{response}->{headers}->{ lc $header }, $value, qq{Http response header "$header" eq "$value"} );

    diag( 'Http response headers = ' . np S->{http}->{response}->{headers} );

    return;
}

sub http_response_header_re {
    my ( $header, $value ) = $validator_re->(@_);

    like( S->{http}->{response}->{headers}->{ lc $header }, $value, qq{Http response header "$header" re "$value"} );

    diag( 'Http response headers = ' . np S->{http}->{response}->{headers} );

    return;
}

sub http_response_content_eq {
    my ($content) = $validator_q->(@_);

    is( S->{http}->{response_object}->decoded_content(), $content, qq{Http response content eq "$content"} );

    diag( 'Http response charset = ' . np S->{http}->{response_object}->headers->content_type_charset );

    return;
}

sub http_response_content_re {
    my ($content) = $validator_r->(@_);

    like( S->{http}->{response_object}->decoded_content(), $content, qq{Http response content re "$content"} );

    diag( 'Http response charset = ' . np S->{http}->{response_object}->headers->content_type_charset );

    return;
}

1;
