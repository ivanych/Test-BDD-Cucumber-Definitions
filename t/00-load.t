#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Test::BDD::Cucumber::Definitions' ) || print "Bail out!\n";
}

diag( "Testing Test::BDD::Cucumber::Definitions $Test::BDD::Cucumber::Definitions::VERSION, Perl $], $^X" );
