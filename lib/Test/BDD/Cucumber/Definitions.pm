package Test::BDD::Cucumber::Definitions;

use 5.006;
use strict;
use warnings;

use Exporter qw(import);
use Params::ValidationCompiler qw(validation_for);
use Test::BDD::Cucumber::Definitions::Types qw(:all);
use Test::BDD::Cucumber::StepFile qw(Given When Then);

=head1 NAME

Test::BDD::Cucumber::Definitions - a collection of step definitions for Test
Driven Development

=head1 VERSION

Version 0.39

=cut

our $VERSION = '0.39';

=head1 SYNOPSIS

In file B<features/step_definitions/tbcd_steps.pl>:

    #!/usr/bin/perl

    use strict;
    use warnings;

    use Test::BDD::Cucumber::Definitions::TBCD::In;

In file B<features/site.feature>:

    Feature: Site
        Site tests

    Scenario: Loading the page
        When http request "GET" send "http://metacpan.org"
        Then http response code eq "200"

... and, finally, in the terminal:

    $ pherkin

      Site
        Site tests

        Scenario: Loading the page
          When http request "GET" send "http://metacpan.org"
          Then http response code eq "200"


=head1 EXPORT

The module exports functions C<S>, C<C>, C<Given>, C<When> and C<Then>.
These functions are identical to the same functions from the module
L<Test::BDD::Cucumber>.

Additionally, the module exports several functions for parameter validation.
These functions are exported by the C<:validator> tag.

By default, no functions are exported. All functions must be imported
explicitly.

=cut

our @EXPORT_OK = qw(
    S C Given When Then
    validator_i
    validator_n
    validator_s
    validator_r
    validator_ni
    validator_ns
    validator_nn
    validator_nr
);

our %EXPORT_TAGS = (
    validator => [
        qw(
            validator_i
            validator_n
            validator_s
            validator_r
            validator_ni
            validator_ns
            validator_nn
            validator_nr
            )
    ]
);

sub S { return Test::BDD::Cucumber::StepFile::S }
sub C { return Test::BDD::Cucumber::StepFile::C }

my $validator_i = validation_for(
    params => [

        # value integer
        { type => TbcdInt },
    ]
);

sub validator_i {
    return $validator_i;
}

my $validator_n = validation_for(
    params => [

        # name
        { type => TbcdNonEmptyStr },
    ]
);

sub validator_n {
    return $validator_n;
}

my $validator_s = validation_for(
    params => [

        # value string
        { type => TbcdStr },
    ]
);

sub validator_s {
    return $validator_s;
}

my $validator_r = validation_for(
    params => [

        # value regexp
        { type => TbcdRegexpRef }
    ]
);

sub validator_r {
    return $validator_r;
}

my $validator_ni = validation_for(
    params => [

        # name
        { type => TbcdNonEmptyStr },

        # value int
        { type => TbcdInt },
    ]
);

sub validator_ni {
    return $validator_ni;
}

my $validator_ns = validation_for(
    params => [

        # name
        { type => TbcdNonEmptyStr },

        # value string
        { type => TbcdStr }
    ]
);

sub validator_ns {
    return $validator_ns;
}

my $validator_nn = validation_for(
    params => [

        # value non empty string
        { type => TbcdNonEmptyStr },

        # value non empty string
        { type => TbcdNonEmptyStr },
    ]
);

sub validator_nn {
    return $validator_nn;
}

my $validator_nr = validation_for(
    params => [

        # name
        { type => TbcdNonEmptyStr },

        # value regexp
        { type => TbcdRegexpRef }
    ]
);

sub validator_nr {
    return $validator_nr;
}

=head1 AUTHOR

Mikhail Ivanov C<< <m.ivanych@gmail.com> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2018 Mikhail Ivanov.

This is free software; you can redistribute it and/or modify it
under the same terms as the Perl 5 programming language system itself.

=cut

1;
