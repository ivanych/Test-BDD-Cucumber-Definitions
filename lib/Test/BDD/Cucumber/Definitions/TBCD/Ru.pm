package Test::BDD::Cucumber::Definitions::TBCD::Ru;

use strict;
use warnings;
use utf8;

use Test::BDD::Cucumber::Definitions::HTTP::Ru;
use Test::BDD::Cucumber::Definitions::Struct::Ru;
use Test::BDD::Cucumber::Definitions::Var::Ru;
use Test::BDD::Cucumber::Definitions::Zip::Ru;

our $VERSION = '0.24';

sub import {
    Test::BDD::Cucumber::Definitions::HTTP::Ru->import;
    Test::BDD::Cucumber::Definitions::Struct::Ru->import;
    Test::BDD::Cucumber::Definitions::Var::Ru->import;
    Test::BDD::Cucumber::Definitions::Zip::Ru->import;

    return;
}
1;
