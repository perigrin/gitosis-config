use Test::More tests => 12;

use Gitosis::Config;
use FindBin;

my $file = "$FindBin::Bin/../ex/example.conf";

ok( my $gc = Gitosis::Config->new( file => $file ) );
is( $gc->gitweb, 'no' );
ok( my @groups = $gc->groups, 'has groups' );

for my $group (@groups) {
    isa_ok( $group, 'Gitosis::Config::Group', 'got a Gitosis::Config::Group' );
    ok( $group->{name},    'group has name' );
    ok( $group->{members}, 'group has members' );
}

ok( my @repos = $gc->repos, 'has repos' );
for my $repo (@repos) {
#    isa_ok( $group, 'Gitosis::Config::Repo', 'got a Gitosis::Config::Repo' );
    ok( $repo->{name},  'repo has name' );
    ok( $repo->{owner}, 'repo has owner' );
}

