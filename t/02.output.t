use Test::More tests => 7;

use Gitosis::Config;

ok( my $gc = Gitosis::Config->new(), 'new Gitosis::Config' );
like( $gc->to_string, qr|[gitosis]|, 'containts [gitosis]' );
ok( $gc->gitweb('no'), 'set gitweb = no' );
like( $gc->to_string, qr[gitweb = no], 'contains gitweb = no' );
ok( $gc->add_group( { name => 'group bar', writable => 'foo' } ), 'add group' );
like( $gc->to_string, qr|[group bar]|, 'contains [group bar]' );
ok( $gc->gitweb('no'), 'writable = foo' );
diag $gc->to_string;
