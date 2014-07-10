use 5.006;
use strict;
use warnings FATAL => 'all';
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'WWW::Google::Places',
    license             => 'artistic_2',
    dist_author         => q{Mohammad S Anwar <mohammad.anwar@yahoo.com>},
    dist_version_from   => 'lib/WWW/Google/Places.pm',
    release_status      => 'stable',
    configure_requires  => {
        'Module::Build' => 0,
    },
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'JSON'                   => 0,
        'Moo'                    => 0,
        'namespace::clean'       => 0,
        'WWW::Google::UserAgent' => 0,
        'WWW::Google::DataTypes' => 0,
    },
    add_to_cleanup     => [ 'WWW-Google-Places-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
