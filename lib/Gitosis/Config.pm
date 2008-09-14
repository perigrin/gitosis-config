package Gitosis::Config;
use Moose;
use Gitosis::Config::Reader;
use Gitosis::Config::Writer;
use MooseX::AttributeHelpers;

sub BUILD {
    my ( $self, $args ) = @_;
    $self->_build_from_config( $args->{config} ) if defined $args->{config};
}

sub _build_from_config {
    my ( $self, $cfg ) = @_;
    for my $attr (qw(gitweb daemon loglevel repositories)) {
        $self->$attr( $cfg->{gitosis}{$attr} );
    }
    for my $name ( grep { $_ =~ /^group/ } keys %$cfg ) {
        my $group = $cfg->{$name};
        ( $group->{name} = $name ) =~ s/^group\s+//;
        $self->add_group($group);
    }

    for my $name ( grep { $_ =~ /^repo/ } keys %$cfg ) {
        my $repo = $cfg->{$name};
        ( $repo->{name} = $name ) =~ s/^repo\s+//;
        $self->add_repo($repo);
    }
}

has [qw(gitweb daemon loglevel repositories)] => (
    isa => 'Maybe[Str]',
    is  => 'rw',
);

has groups => (
    metaclass  => 'Collection::Array',
    isa        => 'ArrayRef[HashRef]',
    is         => 'ro',
    auto_deref => 1,
    lazy_build => 1,
    provides   => { push => 'add_group', }
);

sub _build_groups { [] }

has repos => (
    metaclass  => 'Collection::Array',
    isa        => 'ArrayRef[HashRef]',
    is         => 'ro',
    auto_deref => 1,
    lazy_build => 1,
    provides   => { push => 'add_repo', }
);

sub _build_repos { [] }

#
# METHODS
#

sub new_from_file {
    confess "$_[1] doesn't exist" unless -e $_[1];
    return ( blessed $_[0] || $_[0] )
      ->new( config => Gitosis::Config::Reader->read_file( $_[1] ) );
}

sub to_string {
    Gitosis::Config::Writer->write_string( $_[0] );
}

no Moose;
1;
__END__


=head1 NAME

Gitosis::Config - [One line description of module's purpose here]


=head1 VERSION

This document describes Gitosis::Config version 0.0.1


=head1 SYNOPSIS

    use Gitosis::Config;

=for author to fill in:
    Brief code example(s) here showing commonest usage(s).
    This section will be as far as many users bother reading
    so make it as educational and exeplary as possible.
  
  
=head1 DESCRIPTION

=for author to fill in:
    Write a full description of the module and its features here.
    Use subsections (=head2, =head3) as appropriate.


=head1 INTERFACE 

=for author to fill in:
    Write a separate section listing the public components of the modules
    interface. These normally consist of either subroutines that may be
    exported, or methods that may be called on objects belonging to the
    classes provided by the module.


=head1 DIAGNOSTICS

=for author to fill in:
    List every single error and warning message that the module can
    generate (even the ones that will "never happen"), with a full
    explanation of each problem, one or more likely causes, and any
    suggested remedies.

=over

=item C<< Error message here, perhaps with %s placeholders >>

[Description of error here]

=item C<< Another error message here >>

[Description of error here]

[Et cetera, et cetera]

=back


=head1 CONFIGURATION AND ENVIRONMENT

=for author to fill in:
    A full explanation of any configuration system(s) used by the
    module, including the names and locations of any configuration
    files, and the meaning of any environment variables or properties
    that can be set. These descriptions must also include details of any
    configuration language used.
  
Gitosis::Config requires no configuration files or environment variables.


=head1 DEPENDENCIES

=for author to fill in:
    A list of all the other modules that this module relies upon,
    including any restrictions on versions, and an indication whether
    the module is part of the standard Perl distribution, part of the
    module's distribution, or must be installed separately. ]

None.


=head1 INCOMPATIBILITIES

=for author to fill in:
    A list of any modules that this module cannot be used in conjunction
    with. This may be due to name conflicts in the interface, or
    competition for system or program resources, or due to internal
    limitations of Perl (for example, many modules that use source code
    filters are mutually incompatible).

None reported.


=head1 BUGS AND LIMITATIONS

=for author to fill in:
    A list of known problems with the module, together with some
    indication Whether they are likely to be fixed in an upcoming
    release. Also a list of restrictions on the features the module
    does provide: data types that cannot be handled, performance issues
    and the circumstances in which they may arise, practical
    limitations on the size of data sets, special cases that are not
    (yet) handled, etc.

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-gitosis-config@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.


=head1 AUTHOR

Chris Prather  C<< <perigrin@cpan.org> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2008, Chris Prather C<< <perigrin@cpan.org> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
