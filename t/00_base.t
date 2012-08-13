# $Id: 00_base.t 34 2008-12-07 06:47:25Z roland $
# $Revision: 34 $
# $HeadURL: svn+ssh://ipenburg.xs4all.nl/srv/svnroot/debbie/trunk/Date-Extract-P800Picture/t/00_base.t $
# $Date: 2008-12-07 07:47:25 +0100 (Sun, 07 Dec 2008) $

use Test::More;
use DateTime;

BEGIN {
    @methods = qw(extract filename);
    plan tests => ( 7 + @methods );
    ok(1);    # If we made it this far, we're ok.
    use_ok('Date::Extract::P800Picture');
}
my $parser = new_ok('Date::Extract::P800Picture');

@Date::Extract::P800Picture::Sub::ISA = qw(Date::Extract::P800Picture);
TODO: {
    todo_skip 'Empty subclass of Class::Meta::Express issue', 1 if 1;
my $parser_sub = new_ok('Date::Extract::P800Picture::Sub');
}

foreach my $method (@methods) {
    can_ok( 'Date::Extract::P800Picture', $method );
}
my $datetime  = $parser->extract("8B421234.JPG");
my $datetime2 = DateTime->new(
    year  => 2008,
    month => 12,
    day   => 5,
    hour  => 2,
);
is( ref $datetime, ref $datetime2, 'extract method returns DateTime object' );
is_deeply( $datetime, $datetime2,
    'extract method returns DateTime object with correct values' );
$parser = Date::Extract::P800Picture->new();
is(
    eval '$parser->extract()',
    undef,
    "unset filename error catch"
);
