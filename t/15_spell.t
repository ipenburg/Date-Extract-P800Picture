# $Id: 13_critic.t 26 2008-12-06 03:55:22Z roland $
# $Revision: 26 $
# $HeadURL: svn+ssh://ipenburg.xs4all.nl/srv/svnroot/debbie/trunk/Date-Extract-P800Picture/t/13_critic.t $
# $Date: 2008-12-06 04:55:22 +0100 (Sat, 06 Dec 2008) $

use strict;
use warnings;
use English;
use Test::More;

if ( not $ENV{TEST_AUTHOR} ) {
    my $msg = 'Author test. Set $ENV{TEST_AUTHOR} to a true value to run.';
    plan( skip_all => $msg );
}

eval { require Test::Spelling; };

if ($EVAL_ERROR) {
    my $msg = 'Test::Spelling required to check spelling of POD';
    plan( skip_all => $msg );
}

Test::Spelling::add_stopwords(<DATA>);
Test::Spelling::all_pod_files_spelling_ok();
__DATA__
Ipenburg
Sony
JPG
YMDH
