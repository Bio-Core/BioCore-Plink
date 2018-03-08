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
my $file = "$Bin/example/file.txt";
lives_ok
    {
        $plink = $test_class->new();
        }
    'Class instantiated';

my $rsids = $plink->get_rsids_from_file(
    file => $file
    );
my $number_of_rsids = 310;
is(scalar(@{$rsids}), $number_of_rsids, "Number of rs IDs matches expected");
