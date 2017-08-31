#!/usr/bin/perl -w
# A set of regression test helpers for the verilogpp preprocessor.
# Copyright 2017 Google Inc.
# Author: jonmayer@google.com (Jonathan Mayer)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# Limitations under the License.
#
# This is not an official Google product.

package tests::test_utils;

use strict;
use Test::More;
use File::Temp qw/ tempfile /;

BEGIN {
  require Exporter;
  our @ISA = qw(Exporter);
  our @EXPORT = qw(DoMethodAndCompare
                   InstantiateAndCompare
                   InstantiateAndComparePretty
                   ExpandCodeModuleAndCompare
                   ExpandAndCompare
                   );
}

# Runs a method of an object with the provided arguments, and captures
# the results written to STDOUT.  Compares that result to an expected value.
sub DoMethodAndCompare {
  my $name = shift;  # name of the test
  my $object = shift;  # the object to invoke the method on
  my $method_reference = shift;  # the method to invoke
  my $args = shift;  # a reference to an array of arguments
  my $expected = shift;  # the expected result

  my $o = new IO::Scalar();
  select $o;
  $method_reference->($object, @$args);
  select STDOUT;
  my $result = ${$o->sref};
  $o->close();
  chomp($result);

  # assert equivalency:
  chomp($expected);
  if ($result eq $expected) {
    pass($name);
  } else {
    my ($a, $aname) = tempfile();
    print $a $result,"\n";
    close($a);
    my ($b, $bname) = tempfile();
    print $b $expected,"\n";
    close($b);
    fail($name);
    system("diff -c ${bname} ${aname}");
  }
}

# Emulates the behavior of an INST macro expansion and compares the result
# against an expected value.
sub InstantiateAndCompare {
  my $name = shift;  # name of the test
  my $prototype = shift;  # an initialized ModuleSpec object describing the
                          # module to instantiate
  my $macro = shift;  # the contents of the INST macro to use when mapping
                      # port names to signal names
  my $expected = shift;  # the expected result of the instantiation
  my $pretty = shift || 0;

  # Test instantiate methods
  my $code = new CodeModule("mytest.v");
  DoMethodAndCompare($name,
    $code, \&CodeModule::expand_instantiate_with_prototype,
    [$prototype, "u_test", $macro, undef, $pretty],
    $expected);
}

# Make a version of InstantiateAndCompare that forces prettyprint=1
sub InstantiateAndComparePretty {
  my $orig_pretty = $main::config{"prettyprint"};
  $main::config{"prettyprint"} = 1;
  InstantiateAndCompare(@_, 1);
  $main::config{"prettyprint"} = $orig_pretty;
}

sub ExpandCodeModuleAndCompare($$$) {
  my $name = shift;
  my $code = shift;
  my $expected = shift;

  # re-generate the expanded text:
  $code->expand_all_macros();

  # mask test-specific text
  $code->{text} =~ s/\(eval \d+\)/(eval NNN)/g;

  # assert equivalency:
  if ($code->{text} eq $expected) {
    pass($name);
  } else {
    my ($a, $aname) = tempfile();
    print $a $code->{text};
    close($a);
    my ($b, $bname) = tempfile();
    print $b $expected;
    close($b);
    fail($name);
    system("diff -c ${bname} ${aname}");
  }
}

# ExpandAndCompare takes a sample piece of expanded verilog,
# re-expands it, and then compares it to see if it matches.
sub ExpandAndCompare($$) {
  my $name = shift;
  my $expected = shift;

  # strip all preprocessor output from the text:
  my $text = $expected;
  $text =~ s(/\*PPSTART\*\/.*?/\*PPSTOP\*\/\n\n)()gso;

  # re-generate the expanded text:
  my $code = new CodeModule("mytest.v");
  $code->set_text($text);
  ExpandCodeModuleAndCompare($name, $code, $expected);
}

1;

