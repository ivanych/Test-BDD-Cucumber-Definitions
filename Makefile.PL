use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Test::BDD::Cucumber::Definitions',
    AUTHOR           => q{Mikhail Ivanov <m.ivanych@gmail.com>},
    VERSION_FROM     => 'lib/Test/BDD/Cucumber/Definitions.pm',
    ABSTRACT_FROM    => 'lib/Test/BDD/Cucumber/Definitions.pm',
    LICENSE          => 'artistic_2',
    PL_FILES         => {},
    MIN_PERL_VERSION => '5.006',
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '0',
    },
    BUILD_REQUIRES => {
        'Test::More' => '0',
    },
    PREREQ_PM => {
        'DDP'                           => 0,
        'HTTP::Tiny'                    => 0,
        'JSON::XS'                      => 0,
        'Moose::Util::TypeConstraints'  => 0,
        'Params::ValidationCompiler'    => 0,
        'Test::BDD::Cucumber'           => 0,
        'Try::Tiny'                     => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Test-BDD-Cucumber-Definitions-*' },
);
