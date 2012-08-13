use 5.006000;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Date::Extract::P800Picture',
    VERSION_FROM      => 'lib/Date/Extract/P800Picture.pm', # finds $VERSION
    PREREQ_PM         => {
		POSIX					=> 1.13,
		Error					=> 0.17,
		English					=> 1.04,
		Readonly				=> 1.03,
		DateTime				=> 0.45,
		Class::Meta::Express	=> 0.10,
		Test::More				=> 0.86,
	},
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Date/Extract/P800Picture.pm', # retrieve abstract from module
       AUTHOR         => 'Roland van Ipenburg <ipenburg@xs4all.nl>') : ()),
);
