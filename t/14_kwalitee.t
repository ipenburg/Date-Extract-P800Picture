# $Id: 13_critic.t 26 2008-12-06 03:55:22Z roland $
# $Revision: 26 $
# $HeadURL: svn+ssh://ipenburg.xs4all.nl/srv/svnroot/debbie/trunk/Date-Extract-P800Picture/t/13_critic.t $
# $Date: 2008-12-06 04:55:22 +0100 (Sat, 06 Dec 2008) $

use Test::More;

eval {
    require Test::Kwalitee;
    Test::Kwalitee->import( tests => [qw( -has_meta_yml)] );
};

plan( skip_all => 'Test::Kwalitee not installed; skipping' ) if $@;
