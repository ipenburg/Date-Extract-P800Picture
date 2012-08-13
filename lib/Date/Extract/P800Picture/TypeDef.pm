package Date::Extract::P800Picture::TypeDef;
use strict;
use warnings;

# $Id: TypeDef.pm 35 2008-12-07 07:53:05Z roland $
# $Revision: 35 $
# $HeadURL: svn+ssh://ipenburg.xs4all.nl/srv/svnroot/debbie/trunk/Date-Extract-P800Picture/lib/Date/Extract/P800Picture/TypeDef.pm $
# $Date: 2008-12-07 08:53:05 +0100 (Sun, 07 Dec 2008) $

our $VERSION = '0.01';

use Class::Meta::Type;
use DateTime;
use Error;

my $type_datetime = Class::Meta::Type->add(
    key  => 'datetime',
    desc => 'DateTime object',
    name => 'DateTime Object',
);

1;

__END__

=head1 NAME

Date::Extract::P800Picture::TypeDef - class for defining
a L<DateTime> property.

=head1 VERSION

=head1 SYNOPSIS

	use Class::Meta::Express;
	use Date::Extract::P800Picture::TypeDef;

	class {
		has datetime	=> (
			is 		=> 'datetime',
			default => sub { DateTime->new( year => 2000) },
		);
	};

=head1 DESCRIPTION

The B<Date::Extract::P800Picture:TypeDef> module makes it possible to use a
L<DateTime> class as property of a L<Class::Meta> defined class.

=head1 SUBROUTINES/METHODS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=head1 INCOMPATIBILITIES

=head1 DIAGNOSTICS

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Roland van Ipenburg, E<lt>ipenburg@xs4all.nlE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2008 by Roland van Ipenburg

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.

=cut
