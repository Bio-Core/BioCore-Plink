package BioCore::Plink::Extract;
use Moose::Role;
use MooseX::Params::Validate;

use strict;
use warnings FATAL => 'all';
use namespace::autoclean;
use autodie;

=head1 NAME

BioCore::Plink::Extract

=head1 SYNOPSIS

A Perl Moose role for extracting RS (SNP) IDs from a PED file.

=head1 ATTRIBUTES AND DELEGATES

=head1 SUBROUTINES/METHODS

# get RSIDs from text file
=head2 $obj->get_rsids_from_file()

Get a list of RS IDs from a text file

=head3 Arguments:

=over 2

=item * file: text file containing RS IDs

=back

=cut

sub get_rsids_from_file {
    my $self = shift;
    my %args = validated_hash(
        \@_,
        file => {
            isa         => 'Str',
            required    => 1
            }
        );

    open(my $ifh, '<', $args{'file'});
    my @rsids;
    while(my $line = <$ifh>) {
        $line =~ s/^\s+//;
        $line =~ s/\s+$//;

        push(@rsids, $line);
        }

    return(\@rsids);
    }

# get rsids and corresponding index from .map file
=head2 $obj->get_rsid_and_index_from_map_file()

Get the matching rs IDs and corresponding index from
a .map file.

=head3 Arguments:

=over 2

=item * rsids: list of rs IDs

=item * map: .map file from Plink

=back

=cut

sub get_rsid_and_index_from_map_file {
    my $self = shift;
    my %args = validated_hash(
        \@_,
        rsids => {
            isa         => 'ArrayRef',
            required    => 1
            },
        map => {
            isa         => 'Str',
            required    => 1
            }
        );
    my $rsid_index = 1;
    my $line_number = 1;
    my %_rsid_hash;
    open(my $mapfh, '<', $args{'map'});

    # create the hash of rsids with indexes
    while(my $line = <$mapfh>) {
        $line =~ s/^\s+//;
        $line =~ s/\s+$//;

        my @_input_array = split("\t", $line);
        my $_rsid = $_input_array[$rsid_index];
        $_rsid_hash{$_rsid} = $line_number;
        $line_number++;
        }

    my %_rsids_and_index;
    foreach my $_rsid_search (@{ $args{'rsids'} }) {
        # check for the rsid of interest
        if (exists $_rsid_hash{$_rsid_search}) {
            $_rsids_and_index{$_rsid_search} = $_rsid_hash{$_rsid_search}
            }
        }

    return(\%_rsids_and_index);
    }

# get rsid column of data from .ped file


# append the rsid column of data from the .ped file and
# construct a matrix containing the 310 RSID numbers as columns and
# 433k patients as rows


=head1 AUTHOR

Richard J. de Borja, C<< <richard.deborja at uhnresearch.ca> >>

=head1 ACKNOWLEDGEMENT

=head1 BUGS

Please report any bugs or feature requests to C<bug-test-test at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=test-test>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BioCore::Plink::Extract

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=test-test>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/test-test>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/test-test>

=item * Search CPAN

L<http://search.cpan.org/dist/test-test/>

=back

=head1 ACKNOWLEDGEMENTS

=head1 LICENSE AND COPYRIGHT

Copyright 2017 Richard J. de Borja.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

no Moose::Role;

1; # End of BioCore::Plink::Extract
