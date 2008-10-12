use Test::More tests => 8;

use Gitosis::Config;

ok( my $gc = Gitosis::Config->new(), 'new Gitosis::Config' );
like( $gc->to_string, qr|\Q[gitosis]\E|, 'containts [gitosis]' );
ok( $gc->gitweb('no'), 'set gitweb = no' );
like( $gc->to_string, qr[gitweb = no], 'contains gitweb = no' );
ok( $gc->add_group( { name => 'bar', writable => 'foo' } ), 'add group' );
ok($group = $gc->find_group_by_name('bar'), 'lookup group by name');
isa_ok($group, 'Gitosis::Config::Group');
like( $gc->to_string, qr|\Q[group bar]\E|, 'contains [group bar]' );


