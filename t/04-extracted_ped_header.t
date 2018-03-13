use Test::More tests => 2;
use Test::Moose;
use Test::Exception;
use MooseX::ClassCompositor;
use Test::Files;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use File::Temp qw(tempfile tempdir);
use Data::Dumper;

# setup the class creation process
my $test_class_factory = MooseX::ClassCompositor->new(
    { class_basename => 'Test' }
    );

# create a temporary class based on the given Moose::Role package
my $test_class = $test_class_factory->class_for('BioCore::Plink::Extract');

# instantiate the test class based on the given role
my $plink;
lives_ok
    {
        $plink = $test_class->new();
        }
    'Class instantiated';

my $rsid_file = "$Bin/example/file.rsid";
my $map_file = "$Bin/example/file.map";
my $rsids = $plink->get_rsids_from_file(
    file => $rsid_file
    );
my $map_data = $plink->get_rsid_and_index_from_map_file(
    rsids => $rsids,
    map => $map_file
    );
$ped_header = $plink->create_ped_subset_header(
    rsids => $rsids
    );
my $expected_header = join("\t",
    "family_id",
    "sample_id",
    "paternal_id",
    "maternal_id",
    "sex",
    "affection",
    "rs11511647",
    "rs3883674",
    "rs12218882",
    "rs10904045",
    "rs11252127",
    "rs12775203",
    "rs12255619"
    );
is($ped_header, $expected_header, "Header string matches expected");
