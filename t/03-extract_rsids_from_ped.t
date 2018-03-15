use Test::More tests => 3;
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
my $output_file = "test_output.ped";
lives_ok
    {
        $plink = $test_class->new();
        }
    'Class instantiated';
    
my $ped_subset_data = $plink->extract_rsids_from_ped_data(
    ped_file => $ped_file,
    rsid_file => $rsid_file,
    map_file => $map_file
    );
$plink->write_ped_file(
    data => $ped_subset_data,
    file => $output_file
    );
my $expected_file = "$Bin/example/expected_output.ped";
compare_ok($output_file, $expected_file, "Extracted PED matches expected");
unlink($output_file);

# check for early exit when no RSIDs match
$rsid_file = "$Bin/example/non.rsid";
$ped_subset_data = $plink->extract_rsids_from_ped_data(
    ped_file => $ped_file,
    rsid_file => $rsid_file,
    map_file => $map_file
    );
is($ped_subset_data, 42, "No matching RSIDs found");
