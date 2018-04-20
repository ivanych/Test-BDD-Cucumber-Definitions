#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use English qw(-no_match_vars);

if ( not $ENV{AUTHOR_TESTING} ) {
    my $msg = 'Author test.  Set $ENV{AUTHOR_TESTING} to a true value to run.';
    plan( skip_all => $msg );
}

eval { require Test::Perl::Critic; };

if ($EVAL_ERROR) {
    my $msg = 'Test::Perl::Critic required to criticise code';
    plan( skip_all => $msg );
}

Test::Perl::Critic->import();

all_critic_ok();
