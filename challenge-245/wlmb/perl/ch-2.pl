#!/usr/bin/env perl
# Perl weekly challenge 245
# Task 2:  Largest of Three
#
# See https://wlmb.github.io/2023/11/27/PWC245/#task-2-largest-of-three
use v5.36;
use List::Util qw(all);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to find the largest concatenation of numbers N_i which yield a
    multiple of 3.
    FIN
die "Only non-negative numbers allowed" unless all {/\d+/} @ARGV;
my $index=0;
my $total;
my @one;
my @two;
my @sorted= sort{"$a$b"<=>"$b$a"}@ARGV; # increasing order
for(@sorted){
    my $residue=$_%3;
    push @one, $index  if $residue==1;
    push @two, $index  if $residue==2;
    $total+=$residue;
    ++$index;
}
$total%=3;
my @candidates; # if neccesary to remove numbers
if($total==1){
    # remove the smallest number that leaves a residue one
    push @candidates, [$one[0]] if(@one);
    # remove the two smallest numbers that leaves a residue two
    push @candidates, [@two[1,0]] if(@two>=2);
}
if($total==2){
    # remove the two smallest numbers that leaves a residue one
    push @candidates, [@one[1,0]] if(@one>=2);
    # or the smallest numbers that leaves a residue two
    push @candidates, [$two[0]] if(@two);
}
if(@candidates){ # find smallest candidates
    my @to_remove=map {join "", @sorted[@$_]} @candidates;
    my $index_to_remove=@candidates == 2 && $to_remove[1]<$to_remove[0]?1:0;
    splice @sorted, $_, 1 for @{$candidates[$index_to_remove]}; # remove one or two numbers
}
my $result=join "", reverse @sorted;
$result=-1 if $result eq ""; # removed all
$result=0 if $result==0; # 0000...=0 is divisible;
say "@ARGV -> $result";
