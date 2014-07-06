#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 3;

BEGIN {
    use_ok( 'WWW::Google::Places' ) || print "Bail out!\n";
    use_ok( 'WWW::Google::Places::CONSTANTS' ) || print "Bail out!\n";
    use_ok( 'WWW::Google::Params' ) || print "Bail out!\n";
}

diag( "Testing WWW::Google::Places $WWW::Google::Places::VERSION, Perl $], $^X" );
