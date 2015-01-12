use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME               => 'WWW::Google::Places',
    AUTHOR             => q{Mohammad S Anwar <mohammad.anwar@yahoo.com>},
    VERSION_FROM       => 'lib/WWW/Google/Places.pm',
    ABSTRACT_FROM      => 'lib/WWW/Google/Places.pm',
    LICENSE            => 'artistic_2',
    PL_FILES           => {},
    MIN_PERL_VERSION   => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        'JSON'                   => 0,
        'Moo'                    => 0,
        'namespace::clean'       => 0,
        'WWW::Google::UserAgent' => '0.13',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'WWW-Google-Places-*' },
    (eval { ExtUtils::MakeMaker->VERSION(6.46) } ? (META_MERGE => {
        'meta-spec' => { version => 2 },
        provides    => {
            'WWW::Google::Places'               => { file => 'lib/WWW/Google/Places.pm',              version => '0.14' },
            'WWW::Google::Places::Params'       => { file => 'lib/WWW/Google/Places/Params.pm',       version => '0.14' },
            'WWW::Google::Places::SearchResult' => { file => 'lib/WWW/Google/Places/SearchResult.pm', version => '0.14' },
            'WWW::Google::Places::DetailResult' => { file => 'lib/WWW/Google/Places/DetailResult.pm', version => '0.14' },
        },
        resources => {
            repository => {
                type => 'git',
                url  => 'https://github.com/Manwar/WWW-Google-Places.git',
                web  => 'https://github.com/Manwar/WWW-Google-Places',
            },
        }})
     : ()
    ),
);
