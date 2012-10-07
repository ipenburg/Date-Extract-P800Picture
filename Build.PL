use strict;
use warnings;
use Module::Build;
Module::Build->new(
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
    configure_requires => { 'Module::Build' => 0.40, },
    build_requires     => { 'Test::More'    => 0.81, },
    recommends         => {
        'File::Basename'          => 0,
        'Getopt::Long'            => 0,
        'Log::Log4perl'           => 0,
        'Pod::Usage'              => 0,
        'Pod::Usage::CommandLine' => 0,
    },
    script_files => [ qw(bin/p800date bin/p800exif), ],
    sign         => 1,
    meta_merge   => {
        resources => {
            repository => 'https://github.com/ipenburg/Date-Extract-P800Picture'
        }
    },
)->create_build_script;
