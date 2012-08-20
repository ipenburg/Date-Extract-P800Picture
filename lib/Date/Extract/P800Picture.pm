package Date::Extract::P800Picture;
use strict;
use warnings;

use 5.006000;

our $VERSION = '0.04';

use Class::Meta::Express;
use Date::Extract::P800Picture::TypeDef;

use POSIX ();
use English qw( -no_match_vars);
use Error qw(:try);
use DateTime;

use Readonly;
Readonly::Scalar my $EMPTY             => q{};
Readonly::Scalar my $EPOCH_YEAR        => 2000;
Readonly::Scalar my $MONTHS_IN_YEAR    => 12;
Readonly::Scalar my $MAX_DAYS_IN_MONTH => 31;
Readonly::Scalar my $HOURS_IN_DAY      => 24;
Readonly::Scalar my $BASE_36           => 36;
Readonly::Scalar my $TZ                => 'UTC';

Readonly::Scalar my $ERROR_PARSING_YEAR  => q{Could not parse year char '%s'};
Readonly::Scalar my $ERROR_PARSING_MONTH => q{Could not parse month char '%s'};
Readonly::Scalar my $ERROR_PARSING_DAY   => q{Could not parse day char '%s'};
Readonly::Scalar my $ERROR_PARSING_HOUR  => q{Could not parse hour char '%s'};
Readonly::Scalar my $ERROR_MISSING_DATE  => q{No date found in filename '%s'};
Readonly::Scalar my $ERROR_MISSING_FILENAME =>
  q{Filename is not set, nothing to extract};

my $DATE = qr/^([0-9A-Z])([0-9AB])([0-9A-U])([0-9A-N])/ixsm;
my $FILE = qr/^[0-9A-Z][0-9AB][0-9A-U][0-9A-N]\d{4}\.JPG$/ixsm;

class {

    meta 'p800picture';

    ctor 'new';

    has filename => ( is => 'string' );
    has datetime => (
        is      => 'datetime',
        default => sub {
            DateTime->new(
                year      => $EPOCH_YEAR,
                time_zone => $TZ,
            );
        },
    );

    method extract => sub {
        my ( $self, $filename ) = @_;
        ( defined $filename ) && $self->filename($filename);
        if ( defined $self->filename ) {
            my ( $year, $month, $day, $hour ) = $self->filename =~ $DATE;
            if ( defined $year ) {
                $self->_parse( \$year, $BASE_36, $ERROR_PARSING_YEAR )
                  && $self->_parse( \$month, $MONTHS_IN_YEAR,
                    $ERROR_PARSING_MONTH )
                  && $self->_parse( \$day, $MAX_DAYS_IN_MONTH,
                    $ERROR_PARSING_DAY )
                  && $self->_parse( \$hour, $HOURS_IN_DAY, $ERROR_PARSING_HOUR )
                  && try {
                    $self->datetime->set(
                        year  => $year + $EPOCH_YEAR,
                        month => $month + 1,
                        day   => $day + 1,
                        hour  => $hour,
                    );
                }
                catch Error with {
                    my $E = shift;
                    Error->throw(
                        -text   => $E->{-text},
                        -object => $self,
                    );
                }
                finally {};
            }
            else {
                Error->throw(
                    -text   => sprintf( $ERROR_MISSING_DATE, $self->filename ),
                    -object => $self,
                );
            }
        }
        else {
            Error->throw( -text => $ERROR_MISSING_FILENAME, -object => $self, );
        }
        return $self->datetime;
    };

    # Converts a character to a number given base. Changes the referenced part
    # returns true on succes.

    method _parse => (
        code => sub {
            my ( $self, $sr_part, $base, $error_message ) = @_;
            my $n_unparsed = 0;
            local $OS_ERROR = 0;
            if ( defined ${$sr_part} ) {
                ( ${$sr_part}, $n_unparsed ) =
                  POSIX::strtol( ${$sr_part}, $base );
            }
            if (   !defined ${$sr_part}
                || ${$sr_part} eq $EMPTY
                || $n_unparsed != 0
                || $OS_ERROR )
            {
                Error->throw(
                    -text => sprintf $error_message,
                    defined ${$sr_part} ? ${$sr_part} : 'undef',
                    -object => $self,
                );
                ${$sr_part} = undef;
            }
            return defined ${$sr_part};
        },
        view => 'PRIVATE',
    );

};

1;

__END__

=head1 NAME

Date::Extract::P800Picture - class for extracting the date and the hour from
the filename of pictures taken with a Sony-Ericsson P800 camera phone.

=head1 VERSION

=head1 SYNOPSIS

	use Date::Extract::P800Picture;

	$filename = "8B360001.JPG"; # 2008-12-04T6:00:00

	$parser = new Date::Extract::P800Picture();
	$parser = new Date::Extract::P800Picture(filename => $filename);

	$datetime = $parser->extract();
	$datetime = $parser->extract($filename);

=head1 DESCRIPTION

The Sony-Ericsson P800 camera phone stores pictures taken with the camera on
the device with a filename consisting of the date and the hour the picture was
taken, followed by a four digit number and the .JPG extension. The format of
the date and the hour is YMDH, in which the single characters are base 36 to
fit a range of about 36 years, 12 months, 31 days and 24 hours since the year
2000 in a case insensitive US-ASCII representation.

=head1 SUBROUTINES/METHODS

=over 4

=item Date::Extract::P800Picture-E<gt>new()
=item Date::Extract::P800Picture-E<gt>new(filename => $filename)

Constructs a new Date::Extract::P800Picture object.

=item $parser->filename($filename);

Sets the filename to extract the date and hour from.

=item $obj-E<gt>extract()

Extract date and hour from the string and returns it as L<DateTime> object.
Returns undef if no valid date could be extracted.

=back

=head1 CONFIGURATION AND ENVIRONMENT

No configuration and environment settings are used.

=head1 DEPENDENCIES

	L<POSIX>
	L<English>
	L<DateTime>
	L<Readonly>

	L<Class::Meta::Express>
	L<Class::Meta::Type>

	L<Date::Extract::P800Picture::TypeDef>

	L<Test::More>

=head1 INCOMPATIBILITIES

=over 4

To avoid ambiguity between more common date notations and the Sony-Ericsson
P800's date notation this is a separate module. It's highly unlikely that in
any other setting "2000" means the first of January 2002.

=back

=head1 DIAGNOSTICS

An error is thrown when a date can't be extracted from the string:

=over 4

=item * Could not parse year char '%s'

=item * Could not parse month char '%s'

=item * Could not parse day char '%s'

=item * Could not parse hour char '%s'

=item * No date found in filename '%s'

=item * Filename is not set, nothing to extract

=back

=head1 BUGS AND LIMITATIONS

=over 4

=item * Empty subclass test fails, this is probably a Class::Meta::Express
issue. The empty subclass can't be empty, it needs at least:

	use Class::Meta::Express;

	class {
		ctor 'new';
	};

=item * Usually the files are transferred from the P800 to other systems in a
way that hasn't completely preserved the timestamp of the file, so there is no
reliable way to double check the results by comparing the date extracted from
the filename with the timestamp of the file.

=back

=head1 AUTHOR

Roland van Ipenburg, E<lt>ipenburg@xs4all.nlE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009 by Roland van Ipenburg

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.

=cut
