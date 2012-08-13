# $Id: 10_pod-coverage.t 22 2008-12-06 03:16:09Z roland $
# $Revision: 22 $
# $HeadURL: svn+ssh://ipenburg.xs4all.nl/srv/svnroot/debbie/trunk/Date-Extract-P800Picture/t/10_pod-coverage.t $
# $Date: 2008-12-06 04:16:09 +0100 (Sat, 06 Dec 2008) $

use Test::More;
eval "use Test::Pod::Coverage 1.00";
plan skip_all => "Test::Pod::Coverage 1.00 required for testing POD coverage"
  if $@;
all_pod_coverage_ok();
