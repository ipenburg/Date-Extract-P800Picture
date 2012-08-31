use strict;
use warnings;
use Module::Build;
Module::Build->new(
    ( sign => 1 ),
    module_name => 'Date::Extract::P800Picture',
    license     => 'perl',
    dist_author => 'Roland van Ipenburg <ipenburg@xs4all.nl>',
    requires    => {
        'perl'                 => '5.14.0',
        'POSIX'                => 0,
        'Exception::Class'     => 0,
        'English'              => 0,
        'Readonly'             => 0,
        'DateTime'             => 0,
        'Moose'                => 0,
        'namespace::autoclean' => 0,
    },
    build_requires => { 'Test::More' => 0.81, },
)->create_build_script;
