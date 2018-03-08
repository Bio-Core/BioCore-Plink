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
my $map_file = "$Bin/example/file.map";
my $rsid_file = "$Bin/example/file.rsid";
lives_ok
    {
        $plink = $test_class->new();
        }
    'Class instantiated';

# Extract the RSIDs for the interested in SNPs
my $rsids = $plink->get_rsids_from_file(
    file => $rsid_file
    );

my $map_data = $plink->get_rsid_and_index_from_map_file(
    rsids => $rsids,
    map => $map_file
    );
# check the index for  RSID rs12218882 (should be 3)
my $rsid_to_check = "rs12218882";
my $expected_value = "3";
is($map_data->{$rsid_to_check}, $expected_value, "RSID index matches expected");
