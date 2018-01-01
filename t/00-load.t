#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Test::BDD::Definitions' ) || print "Bail out!\n";
}

diag( "Testing Test::BDD::Definitions $Test::BDD::Definitions::VERSION, Perl $], $^X" );
