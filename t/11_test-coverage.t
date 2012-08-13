# $Id: 11_test-coverage.t 22 2008-12-06 03:16:09Z roland $
# $Revision: 22 $
# $HeadURL: svn+ssh://ipenburg.xs4all.nl/srv/svnroot/debbie/trunk/Date-Extract-P800Picture/t/11_test-coverage.t $
# $Date: 2008-12-06 04:16:09 +0100 (Sat, 06 Dec 2008) $

use Test::More;
eval "use Test::TestCoverage 0.08";
plan skip_all => "Test::TestCoverage 0.08 required for testing test coverage"
  if $@;

plan tests => 1;
test_coverage("Date::Extract::P800Picture");

my $obj = Date::Extract::P800Picture->new();
$obj->filename("8B481234.JPG");
$obj->extract();

ok_test_coverage('Date::Extract::P800Picture');
