use Test::More tests => 14;

use Gitosis::Config;

my $file = 'ex/example.conf';

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

ok(my $quux = $gc->find_group_by_name('quux'), 'found group by name');
is($quux->name, 'quux', 'group name correct');