package WWW::Google::Places;

$WWW::Google::Places::VERSION = '0.05';

use 5.006;
use JSON;
use Data::Dumper;

use WWW::Google::UserAgent;
use WWW::Google::DataTypes qw($Boolean $Output $Language);
use WWW::Google::Places::Params qw(validate $FIELDS);

use Moo;
use namespace::clean;
extends 'WWW::Google::UserAgent';

our $BASE_URL = 'https://maps.googleapis.com/maps/api/place';

has 'sensor'   => (is => 'ro', isa => $Boolean,  default => sub { return 'false' });
has 'output'   => (is => 'ro', isa => $Output,   default => sub { return 'json'  });
has 'language' => (is => 'ro', isa => $Language, default => sub { return 'en'    });

=head1 NAME

WWW::Google::Places - Interface to Google Places API.

=head1 VERSION

Version 0.05

=head1 DESCRIPTION

The Google Places API is a service that returns information about Places, defined
within  this  API  as establishments,  geographic location or prominent points of
interest using HTTP request.Place requests specify location as latitude/longitude
coordinates. Users with an API key are allowed 1,000 requests per 24 hour period.
Currently it supports version v3.

=head1 PLACE TYPES

Supported types for Place adds/searches.

    +-------------------------+
    | accounting              |
    | airport                 |
    | amusement_park          |
    | aquarium                |
    | art_gallery             |
    | atm                     |
    | bakery                  |
    | bank                    |
    | bar                     |
    | beauty_salon            |
    | bicycle_store           |
    | book_store              |
    | bowling_alley           |
    | bus_station             |
    | cafe                    |
    | campground              |
    | car_dealer              |
    | car_rental              |
    | car_repair              |
    | car_wash                |
    | casino                  |
    | cemetery                |
    | church                  |
    | city_hall               |
    | clothing_store          |
    | convenience_store       |
    | courthouse              |
    | dentist                 |
    | department_store        |
    | doctor                  |
    | electrician             |
    | electronics_store       |
    | embassy                 |
    | establishment           |
    | finance                 |
    | fire_station            |
    | florist                 |
    | food                    |
    | funeral_home            |
    | furniture_store         |
    | gas_station             |
    | general_contractor      |
    | geocode                 |
    | grocery_or_supermarket  |
    | gym                     |
    | hair_care               |
    | hardware_store          |
    | health                  |
    | hindu_temple            |
    | home_goods_store        |
    | hospital                |
    | insurance_agency        |
    | jewelry_store           |
    | laundry                 |
    | lawyer                  |
    | library                 |
    | liquor_store            |
    | local_government_office |
    | locksmith               |
    | lodging                 |
    | meal_delivery           |
    | meal_takeaway           |
    | mosque                  |
    | movie_rental            |
    | movie_theater           |
    | moving_company          |
    | museum                  |
    | night_club              |
    | painter                 |
    | park                    |
    | parking                 |
    | pet_store               |
    | pharmacy                |
    | physiotherapist         |
    | place_of_worship        |
    | plumber                 |
    | police                  |
    | post_office             |
    | real_estate_agency      |
    | restaurant              |
    | roofing_contractor      |
    | rv_park                 |
    | school                  |
    | shoe_store              |
    | shopping_mall           |
    | spa                     |
    | stadium                 |
    | storage                 |
    | store                   |
    | subway_station          |
    | synagogue               |
    | taxi_stand              |
    | train_station           |
    | travel_agency           |
    | university              |
    | veterinary_care         |
    | zoo                     |
    +-------------------------+

Additional types listed below can be used in Place Searches, but not when adding a Place.

    +-----------------------------+
    | administrative_area_level_1 |
    | administrative_area_level_2 |
    | administrative_area_level_3 |
    | colloquial_area             |
    | country                     |
    | floor                       |
    | intersection                |
    | locality                    |
    | natural_feature             |
    | neighborhood                |
    | political                   |
    | point_of_interest           |
    | post_box                    |
    | postal_code                 |
    | postal_code_prefix          |
    | postal_town                 |
    | premise                     |
    | room                        |
    | route                       |
    | street_address              |
    | street_number               |
    | sublocality                 |
    | sublocality_level_4         |
    | sublocality_level_5         |
    | sublocality_level_3         |
    | sublocality_level_2         |
    | sublocality_level_1         |
    | subpremise                  |
    | transit_station             |
    +-----------------------------+

=head1 LANGUAGES

    +-------+-------------------------+
    | Code  | Name                    |
    +-------+-------------------------+
    | ar    | ARABIC                  |
    | eu    | BASQUE                  |
    | bg    | BULGARIAN               |
    | bn    | BENGALI                 |
    | ca    | CATALAN                 |
    | cs    | CZECH                   |
    | da    | DANISH                  |
    | de    | GERMAN                  |
    | el    | GREEK                   |
    | en    | ENGLISH                 |
    | en-AU | ENGLISH (AUSTRALIAN)    |
    | en-GB | ENGLISH (GREAT BRITAIN) |
    | es    | SPANISH                 |
    | eu    | BASQUE                  |
    | fa    | FARSI                   |
    | fi    | FINNISH                 |
    | fil   | FILIPINO                |
    | fr    | FRENCH                  |
    | gl    | GALICIAN                |
    | gu    | GUJARATI                |
    | hi    | HINDI                   |
    | hr    | CROATIAN                |
    | hu    | HUNGARIAN               |
    | id    | INDONESIAN              |
    | it    | ITALIAN                 |
    | iw    | HEBREW                  |
    | ja    | JAPANESE                |
    | kn    | KANNADA                 |
    | ko    | KOREAN                  |
    | lt    | LITHUANIAN              |
    | lv    | LATVIAN                 |
    | ml    | MALAYALAM               |
    | mr    | MARATHI                 |
    | nl    | DUTCH                   |
    | no    | NORWEGIAN               |
    | pl    | POLISH                  |
    | pt    | PORTUGUESE              |
    | pt-BR | PORTUGUESE (BRAZIL)     |
    | pt-PT | PORTUGUESE (PORTUGAL)   |
    | ro    | ROMANIAN                |
    | ru    | RUSSIAN                 |
    | sk    | SLOVAK                  |
    | sl    | SLOVENIAN               |
    | sr    | SERBIAN                 |
    | sv    | SWEDISH                 |
    | tl    | TAGALOG                 |
    | ta    | TAMIL                   |
    | te    | TELUGU                  |
    | th    | THAI                    |
    | tr    | TURKISH                 |
    | uk    | UKRAINIAN               |
    | vi    | VIETNAMESE              |
    | zh-CN | CHINESE (SIMPLIFIED)    |
    | zh-TW | CHINESE (TRADITIONAL)   |
    +-------+-------------------------+

=head1 CONSTRUCTOR

The constructor expects your application API Key and sensor at the least that you
can  get it for FREE from Google.

    +-----------+--------------------------------------------------------------------------------------+
    | Parameter | Meaning                                                                              |
    +-----------+--------------------------------------------------------------------------------------+
    | api_key   | Your application API key. You should supply a valid API key with all requests. Get a |
    |           | key from the Google APIs console. This must be provided.                             |
    | sensor    | Indicates whether or not the Place request came from a device using a location sensor|
    |           | (e.g. a GPS) to determine the location sent in this request. This value must be      |
    |           | either true or false. This must be provided.                                         |
    | language  | The language code, indicating in which language the results should be returned. The  |
    |           | default is en.                                                                       |
    | output    | Output format JSON or XML. Default is JSON.                                          |
    +-----------+--------------------------------------------------------------------------------------+

    use strict; use warnings;
    use WWW::Google::Places;

    my ($api_key, $sensor, $google);
    $api_key = 'Your_API_Key';
    $sensor  = 'true';

    $google  = WWW::Google::Places->new($api_key, $sensor);
    # or
    $google  = WWW::Google::Places->new({'api_key'=>$api_key, sensor=>$sensor});
    # or
    $google  = WWW::Google::Places->new({'api_key'=>$api_key, sensor=>$sensor, language=>'en', output=>'json'});

=head1 METHODS

=head2 search_place()

Searches place.

    +----------+--------------------------------------------------------------------------------+
    | Key      | Description                                                                    |
    +----------+--------------------------------------------------------------------------------+
    | location | The latitude/longitude around which to retrieve Place information. This must be|
    |          | provided as a google.maps.LatLng object. This must be provided.                |
    | radius   | The distance (in meters) within which to return Place results. The recommended |
    |          | best practice is to set radius based on the accuracy of the location signal as |
    |          | given by the location sensor. Note that setting a radius biases results to the |
    |          | indicated area, but may not fully restrict results to the specified area. This |
    |          | must be provided.                                                              |
    | types    | Restricts the results to Places matching at least one of the specified types.  |
    |          | Types should be separated with a pipe symbol.                                  |
    | name     | A term to be matched against the names of Places.                              |
    +----------+--------------------------------------------------------------------------------+

    use strict; use warnings;
    use WWW::Google::Places;

    my ($api_key, $sensor, $google, $places);
    $api_key = 'Your_API_Key';
    $sensor  = 'true';
    $google  = WWW::Google::Places->new($api_key, $sensor);
    $places  = $google->search_place(location=>'-33.8670522,151.1957362', radius=>500);

=cut

sub search {
    my ($self, $values) = @_;

    my $params = [qw(location radius types name)];
    return $self->_result('search', $params, $values);
}

=head2 place_detail()

A Place Detail request returns more comprehensive information about the indicated
place  such as its complete address, phone number, user rating, etc.

    +-----------+--------------------------------------------------------------------------------+
    | Key       | Description                                                                    |
    +-----------+--------------------------------------------------------------------------------+
    | reference | A textual identifier that uniquely identifies a place, returned from a Place   |
    |           | search request. This must be provided.                                         |
    +-----------+--------------------------------------------------------------------------------+

    use strict; use warnings;
    use WWW::Google::Places;

    my ($api_key, $sensor, $reference, $google, $detail);
    $api_key   = 'Your_API_Key';
    $sensor    = 'true';
    $reference = 'Place_reference';
    $google    = WWW::Google::Places->new($api_key, $sensor);
    $detail    = $google->place_detail($reference);

=cut

sub details {
    my ($self, $values) = @_;

    my $params = [qw(reference)];
    return $self->_result('details', $params, $values);
}

=head2 place_checkins()

It indicates that a user has checked in to that Place.Check-in activity from your
application is reflected in the Place search results that are returned -  popular
establishments are ranked more highly making it easy for your user to find likely
matches.As check-in activity changes over time so does the ranking of each Place.

    +-----------+--------------------------------------------------------------------------------+
    | Key       | Description                                                                    |
    +-----------+--------------------------------------------------------------------------------+
    | reference | A textual identifier that uniquely identifies a place, returned from a Place   |
    |           | search request. This must be provided.                                         |
    +-----------+--------------------------------------------------------------------------------+

    use strict; use warnings;
    use WWW::Google::Places;

    my ($api_key, $sensor, $reference, $google, $checkins);
    $api_key   = 'Your_API_Key';
    $sensor    = 'true';
    $reference = 'Place_reference';
    $google    = WWW::Google::Places->new($api_key, $sensor);
    $checkins  = $google->place_checkins($reference);

=cut

sub check_in {
    my ($self, $values) = @_;

    my $params = [qw(reference)];
    return $self->_result('check-in', $params, $values);
}

=head2 add_place()

Add a place to be available for any future search place request.

    +----------+--------------------------------------------------------------------------------+
    | Key      | Description                                                                    |
    +----------+--------------------------------------------------------------------------------+
    | location | The latitude/longitude around which to retrieve Place information. This must   |
    |          | be provided as a google.maps.LatLng object.                                    |
    | accuracy | The accuracy of the location signal on which this request is based, expressed  |
    |          | in meters. This must be provided.                                              |
    | name     | The full text name of the Place.                                               |
    | types    | Restricts the results to Places matching at least one of the specified types.  |
    |          | Types should be separated with a pipe symbol.                                  |
    +----------+--------------------------------------------------------------------------------+

    use strict; use warnings;
    use WWW::Google::Places;

    my ($api_key, $sensor, $google, $status);
    $api_key = 'Your_API_Key';
    $sensor  = 'true';
    $google  = WWW::Google::Places->new($api_key, $sensor);
    $stetus  = $google->add_place('location'=>'-33.8669710,151.1958750', accuracy=>40, name=>'Google Shoes!');

=head2 delete_place()

Delete a place as given reference. Place can  be  deleted by the same application
that has added it in the first place.Once moderated and added into the full Place
Search results, a Place  can  no longer  be deleted. Places that are not accepted
by  the  moderation  process  will continue to be visible to the application that
submitted them.

    +-----------+--------------------------------------------------------------------------------+
    | Key       | Description                                                                    |
    +-----------+--------------------------------------------------------------------------------+
    | reference | A textual identifier that uniquely identifies a place, returned from a Place   |
    |           | search request. This must be provided.                                         |
    +-----------+--------------------------------------------------------------------------------+

    use strict; use warnings;
    use WWW::Google::Places;

    my ($api_key, $sensor, $reference, $google, $status);
    $api_key   = 'Your_API_Key';
    $sensor    = 'true';
    $reference = 'Place_reference';
    $google    = WWW::Google::Places->new($api_key, $sensor);
    $status    = $google->delete_place($reference);

=cut

sub _url {
    my ($self, $type) = @_;

    return sprintf("%s/%s/%s?key=%s&sensor=%s&language=%s",
                   $BASE_URL, $type, $self->output, $self->api_key,
                   $self->sensor, $self->language);
}

sub _result {
    my ($self, $type, $params, $values) = @_;

    validate($params, $values);

    my $url = $self->_url($type);
    foreach my $key (@$params) {
	my $_key = "&$key=%" . $FIELDS->{$key}->{type};
	$url .= sprintf($_key, $values->{$key}) if defined $values->{$key};
    }

    my $response = $self->_get($url);
    return from_json($response->{content});
}

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-www-google-places at rt.cpan.org>,
or through the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Google-Places>.
I will be notified, and then you'll automatically be notified of progress on your
bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::Google::Places

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-Google-Places>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-Google-Places>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-Google-Places>

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-Google-Places/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2014 Mohammad S Anwar.

This  program  is  free software; you can redistribute it and/or modify it under
the  terms  of the the Artistic License (2.0). You may obtain a copy of the full
license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any  use,  modification, and distribution of the Standard or Modified Versions is
governed by this Artistic License.By using, modifying or distributing the Package,
you accept this license. Do not use, modify, or distribute the Package, if you do
not accept this license.

If your Modified Version has been derived from a Modified Version made by someone
other than you,you are nevertheless required to ensure that your Modified Version
 complies with the requirements of this license.

This  license  does  not grant you the right to use any trademark,  service mark,
tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge patent license
to make,  have made, use,  offer to sell, sell, import and otherwise transfer the
Package with respect to any patent claims licensable by the Copyright Holder that
are  necessarily  infringed  by  the  Package. If you institute patent litigation
(including  a  cross-claim  or  counterclaim) against any party alleging that the
Package constitutes direct or contributory patent infringement,then this Artistic
License to you shall terminate on the date that such litigation is filed.

Disclaimer  of  Warranty:  THE  PACKAGE  IS  PROVIDED BY THE COPYRIGHT HOLDER AND
CONTRIBUTORS  "AS IS'  AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES. THE IMPLIED
WARRANTIES    OF   MERCHANTABILITY,   FITNESS   FOR   A   PARTICULAR  PURPOSE, OR
NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY YOUR LOCAL LAW. UNLESS
REQUIRED BY LAW, NO COPYRIGHT HOLDER OR CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL,  OR CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE
OF THE PACKAGE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

1; # End of WWW::Google::Places
