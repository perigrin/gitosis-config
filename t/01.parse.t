use Test::More tests => 10;

use Gitosis::Config;
use FindBin;

my $file = "$FindBin::Bin/../ex/example.conf";

ok( my $gc = Gitosis::Config->new(file => $file) );
is( $gc->gitweb, 'no' );
ok( my @groups = $gc->groups, 'has groups' );

for my $group (@groups) {
    ok( $group->{name},    'group has name' );
    ok( $group->{members}, 'group has members' );
}

ok( my @repos = $gc->repos, 'has repos' );
for my $repo (@repos) {
    ok( $repo->{name},  'repo has name' );
    ok( $repo->{owner}, 'repo has owner' );
}

