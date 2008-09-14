use Test::More tests => 10;

use Gitosis::Config;
use FindBin;

my $file = "$FindBin::Bin/../ex/example.conf";

ok( my $gc = Gitosis::Config->new_from_file($file) );
is( $gc->gitweb, 'no' );
ok( my @groups = $gc->groups );

for my $group (@groups) {
    ok( $group->{name} );
    ok( $group->{members} );
}

ok( my @repos = $gc->repos );
for my $repo (@repos) {
    ok( $repo->{name} );
    ok( $repo->{owner} );
}

