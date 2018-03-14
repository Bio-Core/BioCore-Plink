use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'BioCore::Plink',
    license             => 'artistic_2',
    dist_author         => q{Richard J. de Borja <richard.deborja@uhnresearch.ca>},
    dist_version_from   => 'lib/BioCore/Plink.pm',
    release_status      => 'stable',
    dist_abstract       => 'Perl package for the PLINK suite of programs',
    configure_requires => {
        'Module::Build' => '0',
    },
    build_requires => {
        'Test::More' => '0',
        'Test::Files' => '0',
        'Test::Moose' => '0',
        'Test::Exception' => '0',
        'Data::Dumper' => '0',
        'MooseX::ClassCompositor' => '0.008'
    },
    requires => {
        'Moose'             => '2.10',
        'Moose::Role'       => '2.10',
        'Data::Dumper'      => '2.161',
        'MooseX::Params::Validate'  => '0.21'
    },
    add_to_cleanup     => [ 'BioCore-Plink-*' ],
);

$builder->create_build_script();
