#!/usr/bin/perl

use strict;
use warnings;

use Test::Strict tests => 24;

$Test::Strict::TEST_STRICT = 0;

all_perl_files_ok( 'lib', 't' );
