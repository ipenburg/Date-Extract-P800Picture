# $Id: 12_manifest.t 33 2008-12-07 02:45:25Z roland $
# $Revision: 33 $
# $HeadURL: svn+ssh://ipenburg.xs4all.nl/srv/svnroot/debbie/trunk/Date-Extract-P800Picture/t/12_manifest.t $
# $Date: 2008-12-07 03:45:25 +0100 (Sun, 07 Dec 2008) $

use Test::More;
eval "use Test::CheckManifest 1.01";
plan skip_all => "Test::CheckManifest 1.01 required for testing test coverage"
  if $@;
ok_manifest( { filter => [qr/(Debian_CPANTS.txt|\.(svn|bak))/] } );
