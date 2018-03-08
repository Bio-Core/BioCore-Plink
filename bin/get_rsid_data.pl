#!/usr/bin/env perl

### get_rsid_data.pl ##############################################################################
# Get genotype data from Plink output using a list of RSIDs.

### HISTORY #######################################################################################
# Version       Date            Developer           Comments
# 0.01          2018-03-06      rdeborja            initial development

### INCLUDES ######################################################################################
use warnings;
use strict;
use Carp;
use Getopt::Long;
use Pod::Usage;
use BioCore::Plink;
use Data::Dumper;

### COMMAND LINE DEFAULT ARGUMENTS ################################################################
# list of arguments and default values go here as hash key/value pairs
our %opts = (
    ped => undef,
    map => undef,
    rsids => undef,
    );

### MAIN CALLER ###################################################################################
my $result = main();
exit($result);

### FUNCTIONS #####################################################################################

### main ##########################################################################################
# Description:
#   Main subroutine for program
# Input Variables:
#   %opts = command line arguments
# Output Variables:
#   N/A

sub main {
    # get the command line arguments
    GetOptions(
        \%opts,
        "help|?",
        "man",
        "ped|p=s",
        "map|m=s",
        "rsids|r=s"
        ) or pod2usage(64);
    
    pod2usage(1) if $opts{'help'};
    pod2usage(-exitstatus => 0, -verbose => 2) if $opts{'man'};

    while(my ($arg, $value) = each(%opts)) {
        if (!defined($value)) {
            print "ERROR: Missing argument \n";
            pod2usage(128);
            }
        }

    my $plink = BioCore::Plink->new();
    my $rsids = $plink->get_rsids_from_file(
        file => $opts{'rsids'}
        );
    my $map_data = $plink->get_rsid_and_index_from_map_file(
        rsids => $rsids,
        map => $opts{'map'}
        );
    foreach my $rsid (keys %{ $map_data }) {
        print $rsid, "\t", $map_data->{$rsid}, "\n";
        }

    return 0;
    }

__END__

=head1 NAME

get_rsid_data.pl

=head1 SYNOPSIS

B<get_rsid_data.pl> [options] [file ...]

    Options:
    --help          brief help message
    --man           full documentation
    --ped           PED file generated from PLINK (required)
    --map           MAP file generated from PLINK (requried)
    --rsids         a file containing rows of RSIDs of interest (required)

=head1 OPTIONS

=over 8

=item B<--help>

Print a brief help message and exit.

=item B<--man>

Print the manual page.

=item B<--ped>

A PED file generated from PLINK.

=item B<--map>

A MAP file generated from PLINK.

=item B<--rsids>

A file containing a list of RSIDs with each RSID as a single entry
per row.

=back

=head1 DESCRIPTION

B<get_rsid_data.pl> Get genotype data from Plink output using a list of RSIDs.

=head1 EXAMPLE

get_rsid_data.pl

=head1 AUTHOR

Richard J. de Borja -- Princess Margaret Cancer Centre

=head1 ACKNOWLEDGEMENTS

Carl Viranen -- Princess Margaret Cancer Centre

Zhibin Lu -- Princess Margaret Cancer Centre

=cut

