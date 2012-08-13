use 5.006000;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
	(MM->can('signature_target') ? (SIGN => 1) : () ),
    NAME              => 'Date::Extract::P800Picture',
    VERSION_FROM      => 'lib/Date/Extract/P800Picture.pm', # finds $VERSION
    PREREQ_PM         => {
		POSIX					=> 0,
		Error					=> 0,
		English					=> 0,
		Readonly				=> 0,
		DateTime				=> 0,
		Class::Meta::Express	=> 0,
		Test::More				=> 0,
	},
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Date/Extract/P800Picture.pm', # retrieve abstract from module
       AUTHOR         => 'Roland van Ipenburg <ipenburg@xs4all.nl>') : ()),
);
