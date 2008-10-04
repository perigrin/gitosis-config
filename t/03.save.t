use Test::More tests => 10;
use Test::Exception;

use Gitosis::Config;
my $file = 'gitosis-test.conf';
ok( my $gc = Gitosis::Config->new(), 'new Gitosis::Config' );
like( $gc->to_string, qr|\Q[gitosis]\E|, 'containts [gitosis]' );
ok( $gc->gitweb('no'), 'set gitweb = no' );
like( $gc->to_string, qr[gitweb = no], 'contains gitweb = no' );
ok( $gc->add_group( { name => 'bar', writable => 'foo' } ), 'add group' );
like( $gc->to_string, qr|\Q[group bar]\E|, 'contains [group bar]' );
ok( $gc->gitweb('no'), 'writable = foo' );

dies_ok { $gc->save } 'save fails without a file';

ok( $gc->file($file), 'give it a file' );
ok($gc->save, 'save with a file');
unlink($file);
