#!/usr/bin/env perl

use strict;
use warnings;

use v5.028.1;

use Test::More tests => 10;

my %tests = (
    '0,0,0'        => '0,0,0',
    '0,9999999999' => '0,9999999999',
    '1'            => 1,
    '1,1,1,2,3,4'  => '1,1,1-4',
    '1,2'          => '1,2',
    '1,2,3,4'      => '1-4',
    '10,2,3,4'     => '10,2-4',
    '100,101,102'  => '100-102',
    '3,2,1,0'      => '3,2,1,0',
    '4,3,2'        => '4,3,2',
);

while ( my ( $i, $o ) = each %tests ) {

    my $r = `echo $i | perl ./ch-1.pl`;
    chomp $r;

    is( $r, $o );
}

done_testing 10;
