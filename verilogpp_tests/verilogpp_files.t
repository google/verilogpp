#!/usr/bin/perl -w
# A file-driven regression test for verilogpp.
#
# Iterates through a set of test files (named *.vpp) and regenerates
# each.  The original .vpp then becomes the expected data that is
# compared against the regenerated data.

use strict;
use Cwd 'abs_path';
use Test::More;
use File::Basename;
use File::Temp qw/ tempfile /;
use test_utils;

my $expected_tests = 0;

# ensure that verilogpp is where we expect it to be:
my $VPP = $ENV{'VPP'} || "../verilogpp";
print "vpp: $VPP\n";
ok(-e $VPP, "verilogpp exists");
$expected_tests++;

# run the preprocessor over everything in the test files directory:
my @testfiles = glob(q(./*.vpp));
my $rc = system($VPP,
                "--quieter",
                "-r",
                "--config=./verilogpp.fortest.rc",
                @testfiles);
# we don't check return codes as some test files are expected to fail.

sub VerifyFile($) {
  $expected_tests += 3;  # this method adds 3 checks.
  my $infile = shift;
  my $outfile = $infile;
  $outfile =~ s/.vpp$/.v/;
  isnt($infile, $outfile, "$outfile named appropriately");
  ok(-e $outfile, "$outfile exists");

  my $rc = system("diff -c ${infile} ${outfile}");
  is($rc, 0, "$outfile resynthesized identically");
  if ($rc == 0) {
    # clean up
    unlink($outfile);
  }
}

sub VerifyManifest() {
  $expected_tests += 2;  # this method adds 2 checks
  ok(-e "./preproc.manifest", "preproc.manifest exists");
  my $rc = system("diff -c -I verilogpp\$ ./preproc.manifest{.expected,}");
  is($rc, 0, "preproc.manifest contains expected checksums");
}

# invoke the preprocessor on these files:
foreach my $testfile (@testfiles) {
  VerifyFile($testfile);
}

VerifyManifest();

done_testing($expected_tests);
