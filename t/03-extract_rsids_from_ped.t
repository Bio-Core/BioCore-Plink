use Test::More tests => 1;
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
my $ped_file = "$Bin/example/file.ped";
my $map_file = "$Bin/example/file.map";
my $rsid_file = "$Bin/example/file.rsid";
lives_ok
    {
        $plink = $test_class->new();
        }
    'Class instantiated';
my $rsids = $plink->get_rsids_from_file(
    file => $rsid_file
    );
my $ped_subset_data = $plink->get_rsid_and_index_from_map_file(
    rsids => $rsids,
    map => $map_file
    );
# my $ped_subset_data = $plink->extract_rsids_from_ped_data(
#     ped_file => "$Bin/example/file.ped",
#     rsid_file => "$Bin/example/file.rsid",
#     map_file => "$Bin/example/file.map"
#     );
print Dumper($ped_subset_data);

my $ped_sorted_subset_data = $plink->sort_rsid_hash_by_value(
    map => $ped_subset_data
    );
print Dumper($ped_sorted_subset_data);