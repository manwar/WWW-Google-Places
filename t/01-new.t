#!perl

use strict; use warnings;
use WWW::Google::Places;
use Test::More tests => 5;

my ($api_key, $sensor, $google);
$api_key = 'Your_API_Key';
$sensor  = 'true';

eval { $google = WWW::Google::Places->new(); };
like($@, qr/Missing required arguments: api_key/);

eval { $google = WWW::Google::Places->new({ sensor => $sensor }); };
like($@, qr/Missing required arguments: api_key/);

eval { $google = WWW::Google::Places->new({ api_key => $api_key, language => 'en', sensor => 'falsee' }); };
like($@, qr/isa check for "sensor" failed/);

eval { $google = WWW::Google::Places->new({api_key=>$api_key, sensor=>'false', language=>'enn'}); };
like($@, qr/isa check for "language" failed/);

eval { $google = WWW::Google::Places->new({api_key=>$api_key, sensor=>'false', language=>'en-AUX'}); };
like($@, qr/isa check for "language" failed/);

done_testing();
