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
print Dumper($map_data);
$ped_header = $plink->create_ped_subset_header(
    rsids => $rsids
    );
print $ped_header, "\n";
