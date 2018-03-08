#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'BioCore::Plink' ) || print "Bail out!\n";
}

diag( "Testing BioCore::Plink $BioCore::Plink::VERSION, Perl $], $^X" );
