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
    configure_requires => {
        'Module::Build' => '0',
    },
    build_requires => {
        'Test::More' => '0',
    },
    requires => {
        #'ABC'              => '1.6',
        #'Foo::Bar::Module' => '5.0401',
    },
    add_to_cleanup     => [ 'BioCore-Plink-*' ],
);

$builder->create_build_script();
