use Test::More tests => 1;

use Gitosis::Config;
use FindBin;

my $file = "$FindBin::Bin/../ex/example.conf";

ok( my $gc = Gitosis::Config->new_from_file($file) );
