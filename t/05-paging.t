#!/usr/bin/env perl

use 5.006;
use strict;
use warnings;

use Test::More tests => 2;
use WWW::Google::Places;

my $places_service = 
    WWW::Google::Places->new( api_key => $ENV{GOOGLE_API_KEY} );
my $los_angeles = '34.0522222,-118.2427778';
{
    my @results = $places_service->search( 
       { location => $los_angeles, 
         radius   => 500,
         types    => 'bar|restaurant',
       },
    );

    cmp_ok( 
       scalar @results, '<=', 20,
       'un-paged search returns a max of 20 results'
    );
}

{   # test paged_search
    # can only test the upper bound of results because some lat/longs
    # can still return <= 20 results 
    my @results = $places_service->paged_search( 
       { location => $los_angeles, 
         radius   => 500,
         types    => 'bar|restaurant',
       },
    );

    cmp_ok(
       scalar @results, '<=', 60,
       'paged search returns a max of 60 results'
    );
}
