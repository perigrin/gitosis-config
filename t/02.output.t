use Test::More tests => 7;

use Gitosis::Config;

ok( my $gc = Gitosis::Config->new(), 'new Gitosis::Config' );
like( $gc->to_string, qr|\Q[gitosis]\E|, 'containts [gitosis]' );
ok( $gc->gitweb('no'), 'set gitweb = no' );
like( $gc->to_string, qr[gitweb = no], 'contains gitweb = no' );
ok( $gc->add_group( { name => 'bar', writable => 'foo' } ), 'add group' );
like( $gc->to_string, qr|\Q[group bar]\E|, 'contains [group bar]' );
ok( $gc->gitweb('no'), 'writable = foo' );

