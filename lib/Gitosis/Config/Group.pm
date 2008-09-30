package Gitosis::Config::Group;
use Moose;
use Moose::Util::TypeConstraints;

has [qw(name)] => (
    isa => 'Str',
    is  => 'ro',
);

subtype 'Gitosis::Config::Group::List' => as 'ArrayRef';
coerce 'Gitosis::Config::Group::List' => from 'Str' => via {
    [ split /\s+/, $_ ];
};

has [qw(writable members)] => (
    isa    => 'Gitosis::Config::Group::List',
    is     => 'rw',
    coerce => 1,
);

no Moose;
1;
