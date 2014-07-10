package WWW::Google::Places::CONSTANTS;

$WWW::Google::Places::CONSTANTS::VERSION = '0.05';

use 5.006;
use strict; use warnings;
use parent 'Exporter';

our @EXPORT_OK = qw(
    $check_location
    $check_types
    $check_num
    $check_str
    $STATUS
);

our $PLACE_TYPES = {
    'accounting'              => 1,
    'airport'                 => 1,
    'amusement_park'          => 1,
    'aquarium'                => 1,
    'art_gallery'             => 1,
    'atm'                     => 1,
    'bakery'                  => 1,
    'bank'                    => 1,
    'bar'                     => 1,
    'beauty_salon'            => 1,
    'bicycle_store'           => 1,
    'book_store'              => 1,
    'bowling_alley'           => 1,
    'bus_station'             => 1,
    'cafe'                    => 1,
    'campground'              => 1,
    'car_dealer'              => 1,
    'car_rental'              => 1,
    'car_repair'              => 1,
    'car_wash'                => 1,
    'casino'                  => 1,
    'cemetery'                => 1,
    'church'                  => 1,
    'city_hall'               => 1,
    'clothing_store'          => 1,
    'convenience_store'       => 1,
    'courthouse'              => 1,
    'dentist'                 => 1,
    'department_store'        => 1,
    'doctor'                  => 1,
    'electrician'             => 1,
    'electronics_store'       => 1,
    'embassy'                 => 1,
    'establishment'           => 1,
    'finance'                 => 1,
    'fire_station'            => 1,
    'florist'                 => 1,
    'food'                    => 1,
    'funeral_home'            => 1,
    'furniture_store'         => 1,
    'gas_station'             => 1,
    'general_contractor'      => 1,
    'geocode'                 => 1,
    'grocery_or_supermarket'  => 1,
    'gym'                     => 1,
    'hair_care'               => 1,
    'hardware_store'          => 1,
    'health'                  => 1,
    'hindu_temple'            => 1,
    'home_goods_store'        => 1,
    'hospital'                => 1,
    'insurance_agency'        => 1,
    'jewelry_store'           => 1,
    'laundry'                 => 1,
    'lawyer'                  => 1,
    'library'                 => 1,
    'liquor_store'            => 1,
    'local_government_office' => 1,
    'locksmith'               => 1,
    'lodging'                 => 1,
    'meal_delivery'           => 1,
    'meal_takeaway'           => 1,
    'mosque'                  => 1,
    'movie_rental'            => 1,
    'movie_theater'           => 1,
    'moving_company'          => 1,
    'museum'                  => 1,
    'night_club'              => 1,
    'painter'                 => 1,
    'park'                    => 1,
    'parking'                 => 1,
    'pet_store'               => 1,
    'pharmacy'                => 1,
    'physiotherapist'         => 1,
    'place_of_worship'        => 1,
    'plumber'                 => 1,
    'police'                  => 1,
    'post_office'             => 1,
    'real_estate_agency'      => 1,
    'restaurant'              => 1,
    'roofing_contractor'      => 1,
    'rv_park'                 => 1,
    'school'                  => 1,
    'shoe_store'              => 1,
    'shopping_mall'           => 1,
    'spa'                     => 1,
    'stadium'                 => 1,
    'storage'                 => 1,
    'store'                   => 1,
    'subway_station'          => 1,
    'synagogue'               => 1,
    'taxi_stand'              => 1,
    'train_station'           => 1,
    'travel_agency'           => 1,
    'university'              => 1,
    'veterinary_care'         => 1,
    'zoo'                     => 1,
};

our $MORE_PLACE_TYPES = {
    'administrative_area_level_1' => 1,
    'administrative_area_level_2' => 1,
    'administrative_area_level_3' => 1,
    'colloquial_area'             => 1,
    'country'                     => 1,
    'floor'                       => 1,
    'intersection'                => 1,
    'locality'                    => 1,
    'natural_feature'             => 1,
    'neighborhood'                => 1,
    'political'                   => 1,
    'point_of_interest'           => 1,
    'post_box'                    => 1,
    'postal_code'                 => 1,
    'postal_code_prefix'          => 1,
    'postal_town'                 => 1,
    'premise'                     => 1,
    'room'                        => 1,
    'route'                       => 1,
    'street_address'              => 1,
    'street_number'               => 1,
    'sublocality'                 => 1,
    'sublocality_level_4'         => 1,
    'sublocality_level_5'         => 1,
    'sublocality_level_3'         => 1,
    'sublocality_level_2'         => 1,
    'sublocality_level_1'         => 1,
    'subpremise'                  => 1,
    'transit_station'             => 1,
};

our $STATUS = {
    'OK'               => 'No errors occurred; the place was successfully detected and at least one result was returned.',
    'ZERO_RESULTS'     => 'Search was successful but returned no results.',
    'OVER_QUERY_LIMIT' => 'You are over your quota.',
    'REQUEST_DENIED'   => 'Your request was denied, generally because of lack of a sensor parameter.',
    'INVALID_REQUEST'  => 'A required query parameter (location or radius) is missing.',
    'UNKNOWN_ERROR'    => 'A server-side error; trying again may be successful.',
};

our $check_location = sub {
    my ($location) = @_;

    my ($latitude, $longitude);
    die "ERROR: Invalid location type data found [$_]"
        unless (($location =~ /\,/)
                &&
                ((($latitude, $longitude) = split/\,/,$location,2)
                 &&
                 (($latitude =~ /^\-?\d+\.?\d+$/)
                  &&
                  ($longitude =~ /^\-?\d+\.?\d+$/)
                 )
                ))
};

our $check_types = sub {
    my ($types) = @_;

    my @types = ();
    die "ERROR: Invalid search type data [$types]"
        unless (defined($types)
                &&
                (@types = split/\|/,$types)
                &&
                (map { exists($PLACE_TYPES->{lc($_)})
                           ||
                           exists($MORE_PLACE_TYPES->{lc($_)})
                 } @types ));
};

our $check_num = sub {
    my ($num) = @_;

    die "ERROR: Invalid NUM data type [$num]"
        unless (defined $num && $num =~ /^\d+$/);
};

our $check_str = sub {
    my ($str) = @_;

    die "ERROR: Invalid STR data type [$str]"
        if (defined $str && $str =~ /^\d+$/);
};

=head1 NAME

WWW::Google::Places::CONSTANTS - Placeholder for CONSTANTS for WWW::Google::Places.

=head1 VERSION

Version 0.05

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-www-google-places at rt.cpan.org>,
or through the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Google-Places>.
I will be notified, and then you'll automatically be notified of progress on your
bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::Google::Places::CONSTANTS

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

1; # End of WWW::Google::Places::CONSTANTS
