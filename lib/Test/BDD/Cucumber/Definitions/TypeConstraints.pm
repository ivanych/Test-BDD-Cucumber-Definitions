package Test::BDD::Cucumber::Definitions::TypeConstraints;

use strict;
use warnings;

use MooseX::Types (
    -declare => [
        qw(
            ValueString
            ValueInteger
            ValueRegexp
            ValueUrl
            ValueJsonpath
            )
    ]
);

use MooseX::Types::Moose qw(Str Int RegexpRef);

use Try::Tiny;

our $VERSION = '0.17';

subtype(
    ValueString,
    as Str,
    message {
        "$_ is not a valid string"
    }
);

subtype(
    ValueInteger,
    as Int,
    message {
        "$_ is not a valid integer"
    }
);

subtype(
    ValueRegexp,
    as RegexpRef,
    message {
        "$_ is not a valid regexp"
    }
);

coerce(
    ValueRegexp,
    from Str,
    via {
        my $value = $_;

        try {
            qr/$value/;    ## no critic [RegularExpressions::RequireExtendedFormatting]
        }
        catch {
            return $value;
        }
    }
);

subtype(
    ValueUrl,
    as Str,
    message {
        "$_ is not a valid URL"
    }
);

coerce(
    ValueUrl,
    from Str,
    via {
        my $value = $_;

        try {
            $value =~ s/\$\{ (.+?) \}/$ENV{$1} || ''/gxe;

            return $value;
        }
        catch {
            return $value;
        }
    }
);

subtype(
    ValueJsonpath,
    as Str,
    message {
        "$_ is not a valid jsonpath"
    }
);

1;
