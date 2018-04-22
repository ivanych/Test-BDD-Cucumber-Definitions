#!/usr/bin/perl

use strict;
use warnings;

use Test::Compile;

my $test = Test::Compile->new();

$test->plan( tests => 22 );

$test->all_files_ok();
