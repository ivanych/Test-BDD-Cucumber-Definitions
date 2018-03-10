package Test::BDD::Cucumber::Definitions::TBCD::In;

use strict;
use warnings;
use utf8;

use Test::BDD::Cucumber::Definitions::HTTP::In;
use Test::BDD::Cucumber::Definitions::Struct::In;
use Test::BDD::Cucumber::Definitions::Var::In;
use Test::BDD::Cucumber::Definitions::Zip::In;

our $VERSION = '0.24';

sub import {
    Test::BDD::Cucumber::Definitions::HTTP::In->import;
    Test::BDD::Cucumber::Definitions::Struct::In->import;
    Test::BDD::Cucumber::Definitions::Var::In->import;
    Test::BDD::Cucumber::Definitions::Zip::In->import;

    return;
}

1;