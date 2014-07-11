#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 4;

BEGIN {
    use_ok( 'WWW::Google::Places'               ) || print "Bail out!\n";
    use_ok( 'WWW::Google::Places::Params'       ) || print "Bail out!\n";
    use_ok( 'WWW::Google::Places::SearchResult' ) || print "Bail out!\n";
    use_ok( 'WWW::Google::Places::DetailResult' ) || print "Bail out!\n";
}

diag( "Testing WWW::Google::Places $WWW::Google::Places::VERSION, Perl $], $^X" );
